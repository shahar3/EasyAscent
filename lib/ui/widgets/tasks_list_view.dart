import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/ui/widgets/task_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TasksListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context);

    return FutureBuilder(
      future: taskManager.getUserTasks("userId"),
      builder: (ctx, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          List<Task> tasks = asyncSnapshot.data;
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (ctx, index) => Divider(
                    color: Colors.grey,
                  ),
                  itemBuilder: (ctx, index) => TaskListItem(
                    task: tasks[index],
                  ),
                  itemCount: tasks.length,
                  padding: EdgeInsets.all(0),
                ),
              ),
            ],
          );
        } else {
          //Show loading indicator
          return Center(
            child: SpinKitDoubleBounce(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
