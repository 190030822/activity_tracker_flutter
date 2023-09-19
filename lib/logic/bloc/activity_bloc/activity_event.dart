part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class AddNewActivityEvent extends ActivityEvent {
   final Activity activity;
  AddNewActivityEvent({required this.activity});
}

class ActivityLoadEvent extends ActivityEvent {
  final int personId;

  ActivityLoadEvent({required this.personId});

}



