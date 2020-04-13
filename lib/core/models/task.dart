import 'package:flutter/cupertino.dart';

import './category.dart';

class Task extends ChangeNotifier {
  final int id;
  final String title;
  final Duration estimationTime;
  final DateTime dueDate;
  final Category category;
  final String uid;
  bool isDone;

  Task(
      {this.id,
      this.title,
      this.estimationTime,
      this.dueDate,
      this.category,
      this.uid,
      this.isDone});

  Task.fromMap(Map data)
      : id = data['id'] ?? 0,
        title = data['title'] ?? "",
        estimationTime = Duration(milliseconds: data['duration']) ?? Duration(),
        dueDate = DateTime.fromMillisecondsSinceEpoch(data['startDate']) ??
            DateTime.now(),
        category = Category.fromMap(data['category']) ?? Category(),
        uid = data['uid'] ?? "",
        isDone = data['isDone'] ?? false;

  toJson() {
    return {
      'id': id,
      'title': title,
      'duration': estimationTime.inMilliseconds,
      'startDate': dueDate.millisecondsSinceEpoch,
      'category': category.toJson(),
      'uid': uid,
      'isDone': isDone,
    };
  }

  toggleDone() {
    this.isDone = !this.isDone;
  }
}
