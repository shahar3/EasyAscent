import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_ascent/core/models/category.dart';
import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/base_model.dart';
import 'package:easy_ascent/core/services/api.dart';
import 'package:easy_ascent/locator.dart';

///This class will hold all of the data related to the tasks of the current user
class TaskManager extends BaseModel {
  Map<DateTime, List<Task>> _tasksByDate;
  DateTime _selectedDate;
  Api _api = locator<Api>();

//  Map<DateTime, List<Task>> get tasksByDate => _tasksByDate;
  DateTime get selectedDate => _selectedDate;

  TaskManager() {
    _selectedDate = DateTime.now();
  }

  Future<Map<DateTime, List<Task>>> getUserTasksByDate(String userId) async {
    _tasksByDate = Map<DateTime, List<Task>>();
    List<Task> userTasks = await _getUserTasks(userId);
    for (Task task in userTasks) {
      DateTime dateOfTask =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      if (!_tasksByDate.containsKey(dateOfTask)) {
        _tasksByDate[dateOfTask] = List<Task>();
      }
      _tasksByDate[dateOfTask].add(task);
    }

    return _tasksByDate;
  }

  Future<Map<Category, List<Task>>> getUserTasksByCategory(
      String userId) async {
    Map<Category, List<Task>> tasksByCategory = Map<Category, List<Task>>();
    List<Task> userTasks = await _getUserTasks(userId);
    for (Task task in userTasks) {
      if (!tasksByCategory.containsKey(task.category)) {
        tasksByCategory[task.category] = List<Task>();
      }

      tasksByCategory[task.category].add(task);
    }

    return tasksByCategory;
  }

  Future<List<Task>> _getUserTasks(String userId) async {
    List<Task> userTasks = List<Task>();
    QuerySnapshot querySnapshot =
        await _api.getTaskDataCollectionForUser(userId);
    for (DocumentSnapshot docSnapshot in querySnapshot.documents) {
      if (docSnapshot.exists) {
        Task task = Task.fromMap(docSnapshot.data);
        userTasks.add(task);
      }
    }

    return userTasks;
  }

  setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future addTask(Task task) async {
    await _api.addDocumentToUser(task.uid, task.id.toString(), task.toJson());
  }

  Future removeTask(Task task) {
    DateTime taskDate =
        DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
    _tasksByDate[taskDate].removeWhere((otherTask) => task.id == otherTask.id);
    //remove task also from db
    _api.removeDocument(task.id.toString(), task.uid);
  }

  void toggleIsDone(Task task) {
    task.toggleDone();
    //Update db
    _api.updateTask(task.toJson(), task.id.toString(), task.uid);
    notifyListeners();
  }
}
