import 'package:flutter/material.dart';

class AddTaskBtn extends StatelessWidget {
  final Function onSave;

  AddTaskBtn({@required this.onSave});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSave();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            "ADD TASK",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
