import 'package:moor/moor.dart';

import 'tables/tasks_table.dart';

part 'app_database.g.dart';

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;
}
