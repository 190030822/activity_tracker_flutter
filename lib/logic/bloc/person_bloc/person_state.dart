part of 'person_bloc.dart';

@immutable
sealed class PersonState {}

final class PersonInitial extends PersonState {}

abstract class PersonListenState extends PersonState {}

class PersonsLoadingState extends PersonState {}

class PersonsLoadedState extends PersonState {
  final List<Person> personsList;
  PersonsLoadedState({required this.personsList});
}

class PersonsEmptyState extends PersonState {}

class PersonErrorState extends PersonListenState {
  final String errMsg;
  PersonErrorState({required this.errMsg});
}

class PersonSuccessState extends PersonListenState {
  final String succMsg;
  PersonSuccessState({required this.succMsg});
}

