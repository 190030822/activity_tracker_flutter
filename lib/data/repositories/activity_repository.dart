import 'package:activity_tracker/data/data_providers/activity_data_provider.dart';
import 'package:activity_tracker/data/models/activity_model.dart';

class ActivityRepository {

  final ActivityData activityData;

  ActivityRepository({required this.activityData});
  
  Future<int> addActivity(Activity activity) async {
    await activityData.insertIntoTable(activity);
    return 1;
  }

  Future<List<Activity>> getActivities(int personId) async {
    final activitiesListMap = await activityData.fetchByPerson(personId);
    return activitiesListMap.map((e) => Activity.fromMap(e)).toList();
  }
}