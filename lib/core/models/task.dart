import './category.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final Duration estimationTime;
  final DateTime dueDate;
  final Category category;

  Task(
      {this.id,
      this.title,
      this.description,
      this.estimationTime,
      this.dueDate,
      this.category});
}
