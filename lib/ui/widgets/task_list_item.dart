import 'package:easy_ascent/core/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({this.task});

  //Todo: Replace all the placeholders
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text("14:30 - 15:15"),
      leading: Container(
        height: MediaQuery.of(context).size.height,
        width: 50,
        color: Colors.red,
        child: Icon(
          Icons.category,
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
        icon: Icon(Icons.edit),
      ),
    );
  }
}
