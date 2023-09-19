import 'package:activity_tracker/data/models/person_model.dart';
import 'package:activity_tracker/data/repositories/person_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {

  List<Person> _personsList = [];
  PersonRepository personRepository;
        
  PersonBloc(this.personRepository) : super(PersonInitial()) {
    on<PersonEvent>((event, emit) {});
    on<PersonsLoadEvent>(personLoadEvent);
    on<PersonsAddEvent>(personsAddEvent);
  }

  void personLoadEvent(PersonsLoadEvent event, Emitter emit) async {
    emit(PersonsLoadingState());
    List<Person> persons= await personRepository.getPersons();
    if (persons.isEmpty) {
      emit(PersonsEmptyState());
    } else {
      _personsList = List.from(persons);
      emit(PersonsLoadedState(personsList: persons));
    }
  }

  void personsAddEvent(PersonsAddEvent event, Emitter emit) async {
    int index = await personRepository.addPerson(event.newPerson);
    if (index == 1) {

      event.newPerson.personId = _personsList.length+1;
      _personsList.add(event.newPerson);
      emit(PersonsLoadedState(personsList: List.from(_personsList)));
      emit(PersonSuccessState(succMsg: "Person Added Sucessfully"));
    } else {
      emit(PersonErrorState(errMsg: "Person not added"));
    }
  }
}
