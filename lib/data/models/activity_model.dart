import 'dart:convert';

import 'package:activity_tracker/data/data_providers/activity_data_provider.dart';

class Activity {


  int? id;
  int personId;
  DateTime wakeUpTime;
  bool gym;
  int meditationTime;
  int readingCount;

  Activity({
    this.id,
    required this.personId,
    required this.wakeUpTime,
    required this.gym,
    required this.meditationTime,
    required this.readingCount,
  });


  Activity copyWith({
    int? id,
    int? personId,
    DateTime? wakeUpTime,
    bool? gym,
    int? meditationTime,
    int? readingCount,
  }) {
    return Activity(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      gym: gym ?? this.gym,
      meditationTime: meditationTime ?? this.meditationTime,
      readingCount: readingCount ?? this.readingCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ActivityData.cId: id,
      ActivityData.cPersonId: personId,
      ActivityData.cWakeUpTime: wakeUpTime.millisecondsSinceEpoch,
      ActivityData.cGym: gym,
      ActivityData.cMeditationTime: meditationTime,
      ActivityData.cReadingCount: readingCount,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map[ActivityData.cId] as int,
      personId: map[ActivityData.cPersonId] as int,
      wakeUpTime: DateTime.fromMillisecondsSinceEpoch(map[ActivityData.cWakeUpTime] as int),
      gym: (map[ActivityData.cGym] as int)  == 1 ? true : false,
      meditationTime: map[ActivityData.cMeditationTime] as int,
      readingCount: map[ActivityData.cReadingCount] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Activity(id: $id, personId: $personId, wakeUpTime: $wakeUpTime, gym: $gym, meditationTime: $meditationTime, readingCount: $readingCount)';
  }

  @override
  bool operator ==(covariant Activity other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.personId == personId &&
      other.wakeUpTime == wakeUpTime &&
      other.gym == gym &&
      other.meditationTime == meditationTime &&
      other.readingCount == readingCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      personId.hashCode ^
      wakeUpTime.hashCode ^
      gym.hashCode ^
      meditationTime.hashCode ^
      readingCount.hashCode;
  }
}
