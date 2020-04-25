import 'package:easy_ascent/core/models/goal.dart';
import 'package:easy_ascent/core/providers/goal_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalsListViewItem extends StatelessWidget {
  final Goal goal;

  GoalsListViewItem({this.goal});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(
        goal.id,
      ),
      child: ListTile(
        title: Text(
          goal.name,
        ),
        subtitle: Text(
          describeEnum(goal.frequency),
        ),
        trailing: Text(
          "${goal.currentCount.toString()}/${goal.countGoal.toString()}",
        ),
      ),
      background: _buildDoneBackground(),
      confirmDismiss: (_) {
        Provider.of<GoalManager>(context, listen: false).toggleDone(goal);
        return Future.value(false);
      },
      onDismissed: (_) {
        print("dismissed");
      },
      direction: DismissDirection.startToEnd,
    );
  }

  _buildDoneBackground() {
    return Container(
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.done,
            color: Colors.white,
            size: 28,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
    );
  }
}
