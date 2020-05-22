import 'package:moor/moor.dart';

class Tasks extends Table {
  TextColumn get uuid => text()();
  TextColumn get name => text().withDefault(const Constant(''))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {uuid};
}
