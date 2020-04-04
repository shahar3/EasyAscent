import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/base_model.dart';

///This class will hold all of the data related to the tasks of the current user
class TaskManager extends BaseModel {
  List<Task> _userTasks;
  DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  TaskManager() {
    _selectedDate = DateTime.now();
  }

  Future<List<Task>> getUserTasks(String userId) async {
    //Todo: implement this method
    return Future.delayed(Duration(seconds: 2), () {
      return [
        Task(id: "1", title: "do workout"),
        Task(id: "2", title: "learn italian")
      ];
    });
  }

  setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
