import 'package:activity_tracker/data/data_providers/person_data_provider.dart';
import 'package:activity_tracker/data/models/person_model.dart';

class PersonRepository {
  
  final PersonData personData;
  PersonRepository({required this.personData});

  Future<int> addPerson(Person person) async{
    await personData.insertIntoTable(person);
    return 1;
  }

  Future<List<Person>> getPersons() async {
    final personsListMap = await personData.fetchFromTable();
    return personsListMap.map((e) => Person.fromMap(e)).toList();
  }
}