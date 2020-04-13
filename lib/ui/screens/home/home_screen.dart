import 'package:easy_ascent/ui/shared/app_side_drawer.dart';
import 'package:easy_ascent/ui/screens/achievements/achievements_screen.dart';
import 'package:easy_ascent/ui/screens/goals/goals_screen.dart';
import 'package:easy_ascent/ui/screens/settings/settings_screen.dart';
import 'package:easy_ascent/ui/screens/tasks/tasks_screen.dart';
import 'package:easy_ascent/ui/widgets/ReusableCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Ascent"),
      ),
      drawer: AppSideDrawer(),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(10.0),
            color: Theme.of(context).accentColor,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ReusableCard(
                          label: "Tasks",
                          imageName: "tasks_icon.png",
                          route: TasksScreen.routeName,
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          label: "Achievements",
                          imageName: "achievements_icon.png",
                          route: AchievementsScreen.routeName,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ReusableCard(
                          label: "Goals",
                          imageName: "goals_icon.png",
                          route: GoalsScreen.routeName,
                        ),
                      ),
                      Expanded(
                        child: ReusableCard(
                          label: "Settings",
                          imageName: "settings_icon.png",
                          route: SettingsScreen.routeName,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
