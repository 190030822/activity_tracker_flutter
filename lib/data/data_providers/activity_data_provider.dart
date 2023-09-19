import 'package:activity_tracker/data/data_providers/data_provider.dart';
import 'package:activity_tracker/data/data_providers/person_data_provider.dart';
import 'package:activity_tracker/data/models/activity_model.dart';
import 'package:sqflite/sqflite.dart';

class ActivityData with DataProvider {

  static const String tableName = "activity";

  static const String cId = "activity_id";
  static const String cWakeUpTime = "wake_up_time";
  static const String cGym = "gym";
  static const String cMeditationTime = "meditation_time";
  static const String cReadingCount = "reading_count";
  static const String cPersonId = "person_id";



  @override
  createTable(Database database) {
    database.execute(""" CREATE TABLE IF NOT EXISTS $tableName(
      $cId INTEGER NOT NULL,
      $cWakeUpTime INTEGER NOT NULL,
      $cGym BOOLEAN NOT NULL ,
      $cMeditationTime INTEGER NOT NULL,
      $cReadingCount INTEGER NOT NULL,
      $cPersonId INTEGER NOT NULL,
      PRIMARY KEY("$cId" AUTOINCREMENT)
      FOREIGN KEY ($cPersonId) REFERENCES ${PersonData.tableName} (${PersonData.cId}) ON DELETE CASCADE
    )""");
  }
  
  @override
  Future<void> insertIntoTable(covariant Activity activity) async {
    Database database = await dataBaseClient.instance;
    database.rawInsert('''
      INSERT INTO $tableName ($cWakeUpTime, $cGym, $cMeditationTime, $cReadingCount, $cPersonId) 
      VALUES (?, ?, ?, ?, ?)''', [activity.wakeUpTime.millisecondsSinceEpoch, activity.gym, activity.meditationTime, activity.readingCount, activity.personId]);
  }

  Future<List<Map<String, Object?>>> fetchByPerson(int personId) async {
    Database database = await dataBaseClient.instance;
    return await database.rawQuery('''
      select * from $tableName where $cPersonId = $personId
    ''');
  }

}
