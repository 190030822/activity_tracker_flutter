import 'package:activity_tracker/data/models/activity_model.dart';
import 'package:activity_tracker/data/repositories/activity_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {

  final ActivityRepository activityRepository;

  List<Activity> _activites = [];

  ActivityBloc({required this.activityRepository}) : super(ActivityInitial()) {
    on<ActivityEvent>((event, emit) {});
    on<AddNewActivityEvent>(addNewActivityEvent);
    on<ActivityLoadEvent>(activityLoadEvent);
  }

  addNewActivityEvent(AddNewActivityEvent event, Emitter emit) async {
    int index = await activityRepository.addActivity(event.activity);
    if (index == 1) {
      _activites.add(event.activity);
      emit(ActivityLoadedState(activities: List.from(_activites)));
      ActivitySuccessState(succMsg: "Activity Added Successfully");
    }
  }

  activityLoadEvent(ActivityLoadEvent event, Emitter emit) async {
    emit(ActivityLoadingState());
    _activites = await activityRepository.getActivities(event.personId);
    if (_activites.isEmpty) {
      emit(ActivityEmptyState());
    } else {
      emit(ActivityLoadedState(activities: List.from(_activites)));
    }
  }

  bool isActivityAdded() {
    if (_activites.isEmpty) return false;
    Activity _activity = _activites.elementAt(_activites.length-1);
    if (_activity.wakeUpTime.day == DateTime.now().day) {
      return true;
    } return false;
  }
}
