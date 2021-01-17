import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

import 'app_database_interface.dart';

class AppDatabaseWeb implements IAppDatabase {
  /// Singleton instance
  static final AppDatabaseWeb instance = AppDatabaseWeb._();

  /// A private constructor. Allows us to create instances of the AppDatabase
  /// only from within the AppDatabase class itself
  AppDatabaseWeb._();

  /// Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

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
    return _dbOpenCompleter.future;
  }

  Future<void> _openDatabase() async {
    final database = await databaseFactoryWeb.openDatabase(dbName);

    /// Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }
}

IAppDatabase getAppDatabase() => AppDatabaseWeb.instance;
