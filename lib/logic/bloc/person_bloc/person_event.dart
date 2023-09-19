part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {}

class PersonsLoadEvent extends PersonEvent {}

class PersonsDetailsEvent extends PersonEvent {}

class PersonsAddEvent extends PersonEvent {
  final Person newPerson;
  PersonsAddEvent({required this.newPerson});
}
