import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/ui/widgets/dates_timeline/date_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../utils.dart';

class DatesTimeline extends StatelessWidget {
  final DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  final int maxDaysCount = Constants.MAXIMUM_DAYS_COUNT;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManager>(builder: (ctx, taskManager, _) {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          DateTime date = startDate.add(Duration(days: index));
          return DateListItem(
            date: date,
            isSelected: Utils.isTheSameDate(taskManager.selectedDate, date),
          );
        },
        itemCount: maxDaysCount,
        scrollDirection: Axis.horizontal,
      );
    });
  }
}
