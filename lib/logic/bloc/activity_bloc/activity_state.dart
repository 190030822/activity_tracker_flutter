part of 'activity_bloc.dart';

@immutable
abstract class ActivityState {}

abstract class ActivityListenState extends ActivityState {}

final class ActivityInitial extends ActivityState {}

final class ActivityLoadingState extends ActivityState {}

final class ActivityLoadedState extends ActivityState {
  final List<Activity> activities;
  ActivityLoadedState({required this.activities});
}

final class ActivityEmptyState extends ActivityState {}

final class ActivitySuccessState extends ActivityListenState {
  final String succMsg;
  ActivitySuccessState({required this.succMsg});
}
