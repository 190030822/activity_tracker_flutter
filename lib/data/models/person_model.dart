import 'dart:convert';

import 'package:activity_tracker/data/data_providers/person_data_provider.dart';

class Person {

  int? personId;
  String name;
  int age;
  String gender;
  double height;
  double weight;
  double bodyMassIndex;
  Person({
    this.personId,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bodyMassIndex,
  });
   

  Person copyWith({
    int? personId,
    String? name,
    int? age,
    String? gender,
    double? height,
    double? weight,
    double? bodyMassIndex,
  }) {
    return Person(
      personId: personId ?? this.personId,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bodyMassIndex: bodyMassIndex ?? this.bodyMassIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PersonData.cId: personId,
      PersonData.cName: name,
      PersonData.cAge: age,
      PersonData.cGender: gender,
      PersonData.cHeight: height,
      PersonData.cWeight: weight,
      PersonData.cBMI: bodyMassIndex,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      personId: map[PersonData.cId] as int,
      name: map[PersonData.cName] as String,
      age: map[PersonData.cAge] as int,
      gender: map[PersonData.cGender] as String,
      height: map[PersonData.cHeight] as double,
      weight: map[PersonData.cWeight] as double,
      bodyMassIndex: map[PersonData.cBMI] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Person(personId: $personId, name: $name, age: $age, gender: $gender, height: $height, weight: $weight, bodyMassIndex: $bodyMassIndex)';
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;
  
    return 
      other.personId == personId &&
      other.name == name &&
      other.age == age &&
      other.gender == gender &&
      other.height == height &&
      other.weight == weight &&
      other.bodyMassIndex == bodyMassIndex;
  }

  @override
  int get hashCode {
    return personId.hashCode ^
      name.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      bodyMassIndex.hashCode;
  }
}
