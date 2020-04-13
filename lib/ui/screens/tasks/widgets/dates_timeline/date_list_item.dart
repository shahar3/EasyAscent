import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../utils.dart';

class DateListItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  DateListItem({@required this.date, @required this.isSelected});

  @override
  Widget build(BuildContext context) {
    TaskManager taskManager = Provider.of<TaskManager>(context, listen: false);
    String monthAbrv = DateFormat.MMM().format(date);
    String day = date.day.toString();
    bool isToday = Utils.isToday(date);
    Map unselectedColors = {
      'backgroundColor': Colors.white,
      'textColor': Colors.black,
    };

    Map selectedColors = {
      'backgroundColor': Color(0xff1C2541),
      'textColor': Colors.white,
    };

    Map colorsPreset = isSelected ? selectedColors : unselectedColors;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          taskManager.setSelectedDate(date);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorsPreset['backgroundColor'],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: isToday
              ? Center(
                  child: Text(
                    "TODAY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorsPreset['textColor'],
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Text(
                      monthAbrv.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorsPreset['textColor'],
                      ),
                    ),
                    Spacer(),
                    Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorsPreset['textColor'],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
