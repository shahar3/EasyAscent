import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  static const String routeName = "/add_task";
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Add a new task"),
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(),
              ),
              Spacer(),
              RaisedButton(
                child: Text("ADD TASK"),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
