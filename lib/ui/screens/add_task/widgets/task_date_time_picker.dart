import 'package:easy_ascent/ui/screens/add_task/widgets/task_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class TaskDateTimePicker extends StatelessWidget {
  final Map<String, dynamic> taskData;
  final _dateTimeController = TextEditingController();

  TaskDateTimePicker({@required this.taskData});

  @override
  Widget build(BuildContext context) {
    return TaskFormField(
      fieldTitle: "Time",
      padding: 0,
      formWidget: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please choose a starting date";
                  }
                  return null;
                },
                controller: _dateTimeController,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  hintText: "Choose starting date",
                  errorStyle: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: 85,
            child: InkWell(
              onTap: () {
                DatePicker.showDateTimePicker(context,
                    minTime: DateTime.now(),
                    currentTime: DateTime.now(), onConfirm: (date) {
                  _dateTimeController.text =
                      DateFormat.yMMMd().add_jm().format(date);
                  taskData['startDate'] = date;
                });
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
