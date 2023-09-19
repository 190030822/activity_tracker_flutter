
import 'package:activity_tracker/data/data_providers/activity_data_provider.dart';
import 'package:activity_tracker/data/data_providers/person_data_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  Database? _database;

  Future<Database> get instance async {

    if (_database != null) {
      return _database!;
    } else {
      _database = await _initalize();
      return _database!;
    }

  }

  Future<String> get fullPath async {

    const dbName = "activity_tracker.db";
    final path = await getDatabasesPath();
    return join(path, dbName);
  }

  Future<Database> _initalize() async {
    String path = await fullPath;
    return await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true
    );
  }

  Future<void> create(Database database, int version) async {
    await PersonData().createTable(database);
    await ActivityData().createTable(database);
  }


}