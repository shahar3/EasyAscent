import 'package:flutter/cupertino.dart';

enum GoalType { Target, Habit }
enum Frequency { Daily, Weekly }

class Goal {
  final int id;
  final String name;
  final GoalType type;
  Frequency frequency;
  int countGoal;
  int currentCount = 0;

  Goal({
    @required this.id,
    @required this.name,
    @required this.type,
    this.frequency,
    this.countGoal,
  });

  void addToCount() {
    currentCount++;
  }
}
