import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils.dart';
import 'task_form_field.dart';

class TaskDurationPicker extends StatelessWidget {
  final Map<String, dynamic> taskData;
  final _durationController = TextEditingController();

  TaskDurationPicker({@required this.taskData});

  @override
  Widget build(BuildContext context) {
    return TaskFormField(
      fieldTitle: "Duration",
      padding: 0,
      formWidget: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  )),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  hintText: "Choose Duration",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please choose task duration";
                  }
                  return null;
                },
                controller: _durationController,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: 85,
            child: InkWell(
              onTap: () async {
                Duration duration = Duration(
                  minutes: 5,
                );

                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext builder) => Container(
                    height: MediaQuery.of(context).copyWith().size.height / 3,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 40,
                              child: CupertinoButton(
                                pressedOpacity: 0.3,
                                padding: EdgeInsets.only(left: 16, top: 0),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                onPressed: () =>
                                    Navigator.pop(context, {'cancel': true}),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: CupertinoButton(
                                pressedOpacity: 0.3,
                                padding: EdgeInsets.only(right: 16),
                                child: Text(
                                  'Done',
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop({'cancel': false});
                                },
                              ),
                            ),
                          ],
                        ),
                        CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          initialTimerDuration: Duration(
                            minutes: 5,
                          ),
                          minuteInterval: 5,
                          onTimerDurationChanged: (Duration changedtimer) {
                            duration = changedtimer;
                          },
                        ),
                      ],
                    ),
                  ),
                ).then((val) {
                  if (!val['cancel']) {
                    _durationController.text = Utils.formatDuration(duration);
                    taskData['duration'] = duration;
                  }
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
                  child: Icon(Icons.timer),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
