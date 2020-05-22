import 'package:moor/moor.dart';
import 'package:moor/moor_web.dart';

QueryExecutor constructQueryExecutor({bool logStatements = false}) =>
    WebDatabase('db', logStatements: logStatements);
