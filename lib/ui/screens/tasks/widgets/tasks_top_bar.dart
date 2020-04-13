import 'package:flutter/material.dart';

import 'dates_timeline/dates_timeline.dart';

class TasksTopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

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
