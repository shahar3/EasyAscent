import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  static const String routeName = "/achievements";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
      ),
      body: Container(
        child: Center(
          child: Text("Achievements"),
        ),
      ),
    );
  }
}
