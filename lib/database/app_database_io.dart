import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart' as path;

import 'app_database_interface.dart';

class AppDatabaseIO implements IAppDatabase {
  /// Singleton instance
  static final AppDatabaseIO instance = AppDatabaseIO._();

  /// A private constructor. Allows us to create instances of the AppDatabase
  /// only from within the AppDatabase class itself
  AppDatabaseIO._();

  /// Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  /// Database object accessor
  @override
  Future<Database> get database async {
    /// If completer is null, AppDatabase class is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      /// Calling _openDatabase will also complete the completer with the database instance

      _openDatabase();
    }

    /// If the database is already opened, awaiting the future will happen instantly.
    /// Otherwise, awaiting the returned future will take some time - until complete() is called
    /// on the Completer in _openDatabase() below.
    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    /// Get a platform-specific directory where persistent app data can be stored
    final dir = await getApplicationSupportDirectory();
    final dbPath = path.join(dir.path, dbName);

    final database = await databaseFactoryIo.openDatabase(dbPath);

    /// Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter!.complete(database);
  }
}

IAppDatabase getAppDatabase() => AppDatabaseIO.instance;
