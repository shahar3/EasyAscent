import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/ui/shared/app_side_drawer.dart';
import 'package:easy_ascent/ui/views/add_task_screen.dart';
import 'package:easy_ascent/ui/widgets/tasks_list_view.dart';
import 'package:easy_ascent/ui/widgets/tasks_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class TasksScreen extends StatelessWidget {
  static const String routeName = "/tasks";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      drawerEdgeDragWidth: 0,
      drawer: AppSideDrawer(),
      body: Column(
        children: <Widget>[
          TasksTopBar(
            scaffoldKey: _scaffoldKey,
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Consumer<TaskManager>(
                      builder: (ctx, taskManager, _) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Utils.formattedDateTitle(taskManager.selectedDate),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TasksListView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: <Widget>[
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddTaskScreen.routeName);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
