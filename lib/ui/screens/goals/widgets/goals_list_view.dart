import 'package:easy_ascent/core/models/goal.dart';
import 'package:easy_ascent/ui/screens/goals/widgets/goals_list_view_item.dart';
import 'package:flutter/material.dart';

class GoalsListView extends StatelessWidget {
  final List<Goal> goals;

  GoalsListView({@required this.goals});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (ctx, i) => Divider(
          height: 1,
          color: Theme.of(context).primaryColor,
        ),
        itemBuilder: (ctx, i) => Center(
          child: GoalsListViewItem(
            goal: goals[i],
          ),
        ),
        itemCount: goals.length,
      ),
    );
  }
}
