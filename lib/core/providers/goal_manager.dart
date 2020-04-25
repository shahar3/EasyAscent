import 'package:easy_ascent/core/models/goal.dart';

import 'base_model.dart';

class GoalManager extends BaseModel {
  List<Goal> _goals;

  Future<List<Goal>> getGoalsForUser(String userId) {
    //Todo: Replace with real data
    List<Goal> mockData = [
      Goal(
        id: 1,
        name: "Drink Water",
        type: GoalType.Habit,
        frequency: Frequency.Daily,
        countGoal: 3,
      ),
      Goal(
        id: 2,
        name: "Go for a run",
        type: GoalType.Habit,
        frequency: Frequency.Weekly,
        countGoal: 2,
      ),
    ];
    return Future.delayed(Duration(seconds: 2)).then((_) => mockData);
  }

  void toggleDone(Goal goal) {
    goal.addToCount();
    notifyListeners();
  }
}
