import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      background: buildDoneBackground(context),
      secondaryBackground: buildDeleteBackground(context),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          //Delete
          return showDialog(
              context: context, builder: (ctx) => _showDeleteAlertDialog(ctx));
          return true;
        } else {
          //Done
          Provider.of<TaskManager>(context, listen: false).toggleIsDone(task);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(task.isDone
                  ? "The task ${task.title} marked as completed"
                  : "The task ${task.title} is unchecked"),
            ),
          );
          return true;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<TaskManager>(context, listen: false).removeTask(task);
        }
      },
      child: Container(
        color: task.isDone ? Colors.green : Colors.white,
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(color: task.isDone ? Colors.white : Colors.black),
          ),
          subtitle: Text(
            _getTaskTimes(task.dueDate, task.estimationTime),
            style: TextStyle(
                color:
                    task.isDone ? Colors.white : Colors.black.withAlpha(120)),
          ),
          leading: Container(
            height: MediaQuery.of(context).size.height,
            width: 50,
            color: task.category.color,
            child: Icon(
              task.category.icon,
              color: Colors.white,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Edit"),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: task.isDone ? Colors.white : Colors.black.withAlpha(120),
            ),
          ),
        ),
      ),
    );
  }

  String _getTaskTimes(DateTime date, Duration duration) {
    String startTime =
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    DateTime endDate = date.add(duration);
    String endTime =
        "${endDate.hour.toString().padLeft(2, '0')}:${endDate.minute.toString().padLeft(2, '0')}";
    return "$startTime - $endTime";
  }

  buildDoneBackground(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.done,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            task.isDone ? "Uncheck" : "Done",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
    );
  }

  buildDeleteBackground(BuildContext context) {
    return Container(
      color: Theme.of(context).errorColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
    );
  }

  _showDeleteAlertDialog(BuildContext ctx) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text("Do you want to remove this task from your list?"),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
        ),
        FlatButton(
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    );
  }
}
