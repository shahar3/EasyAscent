import 'package:charts_flutter/flutter.dart' as charts;
import 'package:easy_ascent/core/models/category.dart';
import 'package:flutter/material.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
//  factory DonutPieChart.withSampleData() {
//    return new DonutPieChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<CategoryTasks, int>> createWithData(
      List<CategoryTasks> data) {
    return [
      new charts.Series<CategoryTasks, int>(
        id: 'Tasks by Category',
        domainFn: (CategoryTasks tasks, _) => tasks.category.id,
        measureFn: (CategoryTasks tasks, _) => tasks.tasks,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class CategoryTasks {
  final Category category;
  final int tasks;

  CategoryTasks(this.category, this.tasks);
}
