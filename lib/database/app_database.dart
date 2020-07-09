import 'package:moor/moor.dart';

import 'tables/tasks_table.dart';

part 'app_database.g.dart';

@UseMoor(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) {
          return m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            // we added the dueDate property in the change from version 1
            await m.deleteTable('sessions');
          }
        },
      );
}
