import 'package:moor/moor.dart';

class Sessions extends Table {
  IntColumn get duration => integer()();
  TextColumn get uuid => text()();
  BoolColumn get isCompleted => boolean()();

  @override
  Set<Column> get primaryKey => {uuid};
}
