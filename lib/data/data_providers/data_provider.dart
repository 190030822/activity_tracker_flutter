import 'package:activity_tracker/data/database/database_client.dart';
import 'package:sqflite/sqflite.dart';

mixin DataProvider {

  final DatabaseClient dataBaseClient = DatabaseClient();

  createTable(Database database);
  insertIntoTable(Object o);
}