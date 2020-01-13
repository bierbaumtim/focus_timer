import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kHydratedBlocKey = 'hydrated_bloc_storage';

class CrossPlatformStorage implements HydratedStorage {
  static CrossPlatformStorage _instance;
  final Map<String, dynamic> _storage;
  final Directory _directory;

  CrossPlatformStorage(this._storage, this._directory);

  static Future<CrossPlatformStorage> getInstance({
    Directory storageDirectory,
  }) async {
    Directory directory;

    if (_instance != null) {
      return _instance;
    }
    var storage = <String, dynamic>{};
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      try {
        storage = json.decode(prefs.getString(kHydratedBlocKey))
            as Map<String, dynamic>;
      } on dynamic catch (e) {
        print(e);
        await prefs?.remove(kHydratedBlocKey);
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      directory = storageDirectory ?? Platform.isIOS
          ? await getApplicationSupportDirectory()
          : await getApplicationDocumentsDirectory();
      var file = File('${directory.path}/$kHydratedBlocKey');

      if (await file.exists()) {
        try {
          storage =
              json.decode(await file.readAsString()) as Map<String, dynamic>;
        } on dynamic catch (_) {
          await file.delete();
        }
      }
    }

    _instance = CrossPlatformStorage(storage, directory);
    return _instance;
  }

  @override
  Future<void> clear() {
    _storage.clear();
    _instance = null;
    writeToStorage(null);
    return null;
  }

  @override
  dynamic read(String key) {
    return _storage[key];
  }

  @override
  Future<void> write(String key, dynamic value) async {
    _storage[key] = value;
    await writeToStorage(json.encode(_storage));
    return _storage[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _storage[key] = null;
    return writeToStorage(json.encode(_storage));
  }

  Future<void> writeToStorage(String content) async {
    print('start writing to file');
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      try {
        if (content == null) {
          await prefs.remove(kHydratedBlocKey);
        } else {
          final success = await prefs.setString(kHydratedBlocKey, content);
          print(success);
        }
      } on dynamic catch (_) {
        await prefs.remove(kHydratedBlocKey);
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      print('Running on Android');
      var file = File('${_directory.path}/$kHydratedBlocKey');

      if (!await file.exists()) {
        file = await file.create();
      }
      try {
        if (content == null) {
          await file.delete();
        } else {
          print('storage saved');
          await file.writeAsString(content);
        }
      } on dynamic catch (e) {
        print(e);
        await file.delete();
      }
    }
  }
}
