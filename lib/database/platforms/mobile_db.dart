import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';

import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;

QueryExecutor constructQueryExecutor({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    return LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
      return VmDatabase(dbFile, logStatements: logStatements);
    });
  }
  if (Platform.isMacOS || Platform.isLinux) {
    final file = File('db.sqlite');
    return VmDatabase(file, logStatements: logStatements);
  }
  // if (Platform.isWindows) {
  //   final file = File('db.sqlite');
  //   return Database(VMDatabase(file, logStatements: logStatements));
  // }
  return VmDatabase.memory(logStatements: logStatements);
}
