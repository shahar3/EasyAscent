import 'package:easy_ascent/ui/widgets/dates_timeline/dates_timeline.dart';
import 'package:flutter/material.dart';

class TasksTopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<String> days = [
    "JUN 10",
    "JUN 11",
    "JUN 12",
    "JUN 13",
    "JUN 14",
    "JUN 15",
    "JUN 16",
    "JUN 17",
    "JUN 18",
    "JUN 19",
    "JUN 20"
  ];

  TasksTopBar({this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: kToolbarHeight,
          ),
          Container(
            width: double.infinity,
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: DatesTimeline(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
