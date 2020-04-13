import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/ui/screens/tasks/tasks_screen.dart';
import 'package:easy_ascent/ui/screens/tasks/widgets/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../tasks_screen.dart';

class TasksListView extends StatelessWidget {
  final List<Task> tasks;
  final Mode displayMode;
  final List<Task> filteredTasks = List<Task>();

  TasksListView({this.tasks, this.displayMode}) {
    tasks.forEach((task) {
      if (displayMode == Mode.Todo) {
        if (!task.isDone) {
          filteredTasks.add(task);
        }
      } else {
        if (task.isDone) {
          filteredTasks.add(task);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return filteredTasks != null && filteredTasks.length > 0
        ? Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (ctx, index) => Divider(
                    color: Colors.grey,
                  ),
                  itemBuilder: (ctx, index) => TaskListItem(
                    task: filteredTasks[index],
                  ),
                  itemCount: filteredTasks.length,
                  padding: EdgeInsets.all(0),
                ),
              ),
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.tasks,
                  size: 42,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(displayMode == Mode.Todo
                    ? "There are no tasks for this date"
                    : "There are no completed tasks for this date"),
              ],
            ),
          );
  }
}
