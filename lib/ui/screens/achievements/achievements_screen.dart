import 'package:easy_ascent/core/models/category.dart';
import 'package:easy_ascent/core/models/task.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/core/providers/task_manager.dart';
import 'package:easy_ascent/ui/shared/app_side_drawer.dart';
import 'package:easy_ascent/ui/shared/padded_content.dart';
import 'package:easy_ascent/ui/widgets/donut_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AchievementsScreen extends StatelessWidget {
  static const String routeName = "/achievements";
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthProvider>(context, listen: false).user.uid;
    TaskManager taskManager = Provider.of<TaskManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
      ),
      drawerEdgeDragWidth: 0,
      drawer: AppSideDrawer(),
      body: PaddedContent(
        childWidget: FutureBuilder(
          future: taskManager.getUserTasksByCategory(userId),
          builder: (ctx, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.done) {
              List<Category> categories = Category.getCategories();
              List<CategoryTasks> categoryTasks = List<CategoryTasks>();
              Map<Category, List<Task>> tasksByCategory =
                  asyncSnapshot.data as Map<Category, List<Task>>;
              int totalTasks = 0;

              List<Widget> categoriesStats = categories.map((category) {
                int numOfTasks = 0;
                if (tasksByCategory.containsKey(category)) {
                  numOfTasks = tasksByCategory[category].length;
                  totalTasks += numOfTasks;
                  categoryTasks.add(CategoryTasks(category, numOfTasks));
                }

                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.solidCircle,
                            size: 8,
                            color: category.color,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(category.name),
                        ],
                      ),
                    ),
                    Text(numOfTasks.toString()),
                  ],
                );
              }).toList();

              return Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        DonutPieChart(
                          DonutPieChart.createWithData(
                            categoryTasks,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Total tasks",
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(totalTasks.toString())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 4 / 2,
                      children: <Widget>[
                        ...categoriesStats,
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: SpinKitDoubleBounce(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
