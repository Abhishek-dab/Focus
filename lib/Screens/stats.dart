import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/statsUtil.dart';
import 'package:bezier_chart/bezier_chart.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fromDate = DateTime.now().subtract(Duration(days: 6));
    final toDate = DateTime.now();

    final date = DateTime.now().subtract(Duration(days: 0));
    final date1 = DateTime.now().subtract(Duration(days: 1));
    final date2 = DateTime.now().subtract(Duration(days: 2));
    final date3 = DateTime.now().subtract(Duration(days: 3));
    final date4 = DateTime.now().subtract(Duration(days: 4));
    final date5 = DateTime.now().subtract(Duration(days: 5));
    final date6 = DateTime.now().subtract(Duration(days: 6));

    return Container(
      alignment: Alignment.center,
      child: StatefulBuilder(
        builder: (context, setState) => FutureBuilder<List<int>>(
            future: getStatsWeek(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CupertinoActivityIndicator();
              }
              if (snapshot.hasError) {
                return Text("Problem");
              }

              final statsList = snapshot.data;
              final todayWorkTime = Duration(minutes: statsList.elementAt(0));
              final yesterdayWorkTime =
                  Duration(minutes: statsList.elementAt(1));

              final lastWeekTime = Duration(
                minutes: statsList.elementAt(0) +
                    statsList.elementAt(1) +
                    statsList.elementAt(2) +
                    statsList.elementAt(3) +
                    statsList.elementAt(4) +
                    statsList.elementAt(5) +
                    statsList.elementAt(6),
              );

              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: BezierChart(
                      bezierChartScale: BezierChartScale.WEEKLY,
                      fromDate: fromDate,
                      toDate: toDate,
                      selectedDate: toDate,
                      series: [
                        BezierLine(
                          label: "Work Time",
                          data: [
                            DataPoint<DateTime>(
                              value: statsList.elementAt(0).toDouble(),
                              xAxis: date,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(1).toDouble(),
                              xAxis: date1,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(2).toDouble(),
                              xAxis: date2,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(3).toDouble(),
                              xAxis: date3,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(4).toDouble(),
                              xAxis: date4,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(5).toDouble(),
                              xAxis: date5,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(6).toDouble(),
                              xAxis: date6,
                            ),
                          ],
                        ),
                      ],
                      config: BezierChartConfig(
                        stepsYAxis: 30,
                        verticalIndicatorStrokeWidth: 3.0,
                        verticalIndicatorColor: Colors.black26,
                        showVerticalIndicator: true,
                        verticalIndicatorFixedPosition: true,
                        displayYAxis: true,
                        displayLinesXAxis: true,
                        physics: ClampingScrollPhysics(),
                        backgroundColor: Colors.red,
                        footerHeight: 40.0,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        colorCard(
                            "Today's Work",
                            "${todayWorkTime.inHours} hours ${todayWorkTime.inMinutes - todayWorkTime.inHours * 60} mins",
                            context,
                            Colors.deepOrange),
                        colorCard(
                            "Yesterday's Work",
                            "${yesterdayWorkTime.inHours} hours ${yesterdayWorkTime.inMinutes - yesterdayWorkTime.inHours * 60} mins",
                            context,
                            Colors.deepPurpleAccent),
                        colorCard(
                            "Last Week's Work",
                            "${lastWeekTime.inHours} hours ${lastWeekTime.inMinutes - lastWeekTime.inHours * 60} mins",
                            context,
                            Colors.green),
                      ],
                    ),
                  ),
                  //   SizedBox(height: 10.0),

                  /// Refresh Page
                ],
              );
            }),
      ),
    );
  }
}

Widget colorCard(
    String text, String fields, BuildContext context, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 9, right: 9),
    padding: EdgeInsets.all(25),
    height: 94,
    width: 250,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${fields.toString()}",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
