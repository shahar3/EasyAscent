import 'package:easy_ascent/core/enums/enums.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/locator.dart';
import 'package:easy_ascent/ui/screens/achievements/achievements_screen.dart';
import 'package:easy_ascent/ui/screens/add_task/add_task_screen.dart';
import 'package:easy_ascent/ui/screens/auth/auth_screen.dart';
import 'package:easy_ascent/ui/screens/goals/goals_screen.dart';
import 'package:easy_ascent/ui/screens/home/home_screen.dart';
import 'package:easy_ascent/ui/screens/landing/landing_screen.dart';
import 'package:easy_ascent/ui/screens/settings/settings_screen.dart';
import 'package:easy_ascent/ui/screens/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
//    debugPaintSizeEnabled = true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TaskManager(),
        ),
      ],
      child: MaterialApp(
        title: 'Easy Ascent',
        theme: ThemeData(
          primaryColor: Color(0xff00adb5),
          accentColor: Color(0xffeeeeee),
          canvasColor: Color(0xff00adb5),
        ),
        home: LandingScreen(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          LandingScreen.routeName: (ctx) => LandingScreen(),
          GoalsScreen.routeName: (ctx) => GoalsScreen(),
          AchievementsScreen.routeName: (ctx) => AchievementsScreen(),
          TasksScreen.routeName: (ctx) => TasksScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          AddTaskScreen.routeName: (ctx) => AddTaskScreen(),
        },
      ),
    );
  }
}
