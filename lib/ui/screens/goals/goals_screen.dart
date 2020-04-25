import 'package:easy_ascent/core/models/goal.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/core/providers/goal_manager.dart';
import 'package:easy_ascent/ui/screens/goals/widgets/goals_list_view.dart';
import 'package:easy_ascent/ui/shared/app_side_drawer.dart';
import 'package:easy_ascent/ui/shared/padded_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

enum Mode { Active, Done }

class GoalsScreen extends StatefulWidget {
  static const String routeName = "/goals";

  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  Mode _mode;

  @override
  void initState() {
    super.initState();
    _mode = Mode.Active;
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthProvider>(context, listen: false).user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("Goals"),
      ),
      drawer: AppSideDrawer(),
      body: Column(
        children: <Widget>[
          PaddedContent(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        "Active",
                        style: TextStyle(
                          color: _mode == Mode.Active
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: _mode == Mode.Active
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(16),
                      ),
                    ),
                    padding: EdgeInsets.all(
                      11,
                    ),
                    margin: EdgeInsets.all(1),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color:
                              _mode == Mode.Done ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: _mode == Mode.Done
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(16),
                      ),
                    ),
                    padding: EdgeInsets.all(
                      11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PaddedContent(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<GoalManager>(
                      builder: (ctx, goalManager, _) {
                        return FutureBuilder(
                          future: goalManager.getGoalsForUser(userId),
                          builder: (ctx, snapshot) {
                            List<Goal> goals = snapshot.data;
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Center(
                                child: SpinKitDoubleBounce(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            } else {
                              return Expanded(
                                child: GoalsListView(
                                  goals: goals,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
