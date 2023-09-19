import 'package:activity_tracker/data/data_providers/data_provider.dart';
import 'package:activity_tracker/data/models/person_model.dart';
import 'package:sqflite/sqflite.dart';

class PersonData with DataProvider{

  static const String tableName = "person";

  static const String cId = "id";
  static const String cName = "name";
  static const String cAge = "age";
  static const String cGender = "gender";
  static const String cHeight = "height";
  static const String cWeight = "weight";
  static const String cBMI = "bmi";


@override
  createTable(Database database) {
    database.execute(""" CREATE TABLE IF NOT EXISTS $tableName(
      $cId INTEGER NOT NULL,
      $cName TEXT NOT NULL,
      $cAge INTEGER NOT NULL,
      $cGender TEXT NOT NULL,
      $cHeight REAL NOT NULL,
      $cWeight REAL NOT NULL,
      $cBMI REAL NOT NULL,
      PRIMARY KEY("$cId" AUTOINCREMENT)
    )""");
    print("dghdgh");
  }
  
  @override
  insertIntoTable(covariant Person person) async {
    Database database = await dataBaseClient.instance;
    await database.rawInsert('''
      INSERT INTO $tableName ($cName, $cAge, $cGender, $cHeight, $cWeight, $cBMI) 
      VALUES (?, ?, ?, ?, ?, ?)''', [person.name, person.age, person.gender, person.height, person.weight, person.bodyMassIndex]);
  }

  Future<List<Map<String, Object?>>> fetchFromTable() async {
    Database database = await dataBaseClient.instance;
    final data =  await database.rawQuery('''
      SELECT * FROM $tableName
    ''');
    return data;
  }
}