import 'package:easy_ascent/ui/screens/add_task/add_task_screen.dart';
import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
