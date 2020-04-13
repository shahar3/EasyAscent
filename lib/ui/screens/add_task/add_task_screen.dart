import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/ui/screens/add_task/widgets/add_task_btn.dart';
import 'package:easy_ascent/ui/screens/add_task/widgets/task_duration_picker.dart';
import 'package:easy_ascent/ui/screens/add_task/widgets/drop_down_categories.dart';
import 'package:easy_ascent/ui/screens/add_task/widgets/task_form_field.dart';
import 'package:easy_ascent/ui/screens/add_task/widgets/task_date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  static const String routeName = "/add_task";

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _taskData = {
    'taskName': '',
    'category': '',
    'startDate': DateTime.now(),
    'duration': Duration(seconds: 0)
  };

  void _onSave() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState.save();

    print(_taskData);
    //Todo: Save to db
    Provider.of<TaskManager>(context, listen: false).addTask(Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _taskData["taskName"],
      category: _taskData['category'],
      estimationTime: _taskData['duration'],
      dueDate: _taskData['startDate'],
      uid: Provider.of<AuthProvider>(context, listen: false).user.uid,
      isDone: false,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Add a new task"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TaskFormField(
                          fieldTitle: "Task Name",
                          fieldIcon: Icons.title,
                          validator: (value) {
                            if (value.isEmpty || value.length < 2) {
                              return 'Task name must be at least 2 chars long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _taskData['taskName'] = value;
                          },
                        ),
                        TaskFormField(
                          fieldTitle: "Category",
                          fieldIcon: Icons.category,
                          formWidget: DropDownCategories(
                            updateCategory: (val) {
                              _taskData['category'] = val;
                            },
                          ),
                        ),
                        TaskDateTimePicker(
                          taskData: _taskData,
                        ),
                        TaskDurationPicker(
                          taskData: _taskData,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: AddTaskBtn(
              onSave: _onSave,
            ),
          )
        ],
      ),
    );
  }
}
