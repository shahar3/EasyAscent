import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/ui/screens/tasks/widgets/add_task_button.dart';
import 'package:easy_ascent/ui/shared/app_side_drawer.dart';
import 'package:easy_ascent/ui/screens/tasks/widgets/tasks_list_view.dart';
import 'package:easy_ascent/ui/screens/tasks/widgets/tasks_top_bar.dart';
import 'package:easy_ascent/ui/shared/padded_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';

enum Mode { Todo, Completed }

class TasksScreen extends StatefulWidget {
  static const String routeName = "/tasks";

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Map<DateTime, List<Task>>> Function(String) _getTasksForUser;
  Mode _displayMode;

  @override
  void initState() {
    super.initState();
    _getTasksForUser =
        Provider.of<TaskManager>(context, listen: false).getUserTasksByDate;
    _displayMode = Mode.Todo;
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthProvider>(context, listen: false).user.uid;

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
            child: PaddedContent(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<TaskManager>(
                      builder: (ctx, taskManager, _) => Text(
                        Utils.formattedDateTitle(taskManager.selectedDate),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _displayMode = Mode.Todo;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(8),
                                    ),
                                    color: _displayMode == Mode.Todo
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "To Do",
                                      style: TextStyle(
                                        color: _displayMode == Mode.Todo
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _displayMode = Mode.Completed;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(8),
                                    ),
                                    color: _displayMode == Mode.Completed
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Completed",
                                      style: TextStyle(
                                        color: _displayMode == Mode.Completed
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _getTasksForUser(userId),
                    builder: (ctx, dataSnapshot) {
                      if (dataSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (dataSnapshot.hasData) {
                          return Expanded(
                            child: Consumer<TaskManager>(
                                builder: (ctx, taskManager, _) {
                              Map<DateTime, List<Task>> tasksByDate =
                                  dataSnapshot.data
                                      as Map<DateTime, List<Task>>;
                              List<Task> taskForSelectedDay = tasksByDate[
                                  DateTime(
                                      taskManager.selectedDate.year,
                                      taskManager.selectedDate.month,
                                      taskManager.selectedDate.day)];
                              return TasksListView(
                                tasks: taskForSelectedDay,
                                displayMode: _displayMode,
                              );
                            }),
                          );
                        } else {
                          return Center(
                            child: Text("no data"),
                          );
                        }
                      } else {
                        return Expanded(
                          child: Center(
                            child: SpinKitDoubleBounce(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          AddTaskButton(),
        ],
      ),
    );
  }
}
