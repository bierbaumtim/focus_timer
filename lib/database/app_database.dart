import 'package:moor/moor.dart';

import 'tables/sessions_table.dart';
import 'tables/tasks_table.dart';

part 'app_database.g.dart';

@UseMoor(tables: [Sessions, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
