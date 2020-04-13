import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
  static const String routeName = "/goals";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goals"),
      ),
      body: Container(
        child: Center(
          child: Text("Goals"),
        ),
      ),
    );
  }
}
