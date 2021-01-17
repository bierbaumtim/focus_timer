import 'package:sembast/sembast.dart';

import 'app_database_stub.dart'
    if (dart.library.io) 'app_database_io.dart'
    if (dart.library.html) 'app_database_web.dart';

abstract class IAppDatabase {
  Future<Database> get database;

  factory IAppDatabase() => getAppDatabase();
}

const dbName = 'app.db';
