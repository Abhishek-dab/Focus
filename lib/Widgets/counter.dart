import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

double percent = 0;

class CounterWorkWidget extends StatelessWidget {
  final double time;
  final int fin;

  const CounterWorkWidget({
    Key key,
    @required this.time,
    @required this.fin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dr = Duration(seconds: time.toInt());
    final String minutes = (dr.inSeconds ~/ 60) > 9.9
        ? (dr.inSeconds ~/ 60).toString()
        : ("0" + (dr.inSeconds ~/ 60).toString());
    final String seconds = (dr.inSeconds.remainder(60) > 9.9
        ? dr.inSeconds.remainder(60).toString()
        : ("0" + dr.inSeconds.remainder(60).toString()));
    int tot = int.parse(minutes) * 60 + int.parse(seconds);

    percent = tot / fin;

    print(percent);
    return Container(
      child: CircularPercentIndicator(
        percent: percent,
        animation: true,
        animateFromLastPercent: true,
        radius: 250.0,
        lineWidth: 20.0,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.green,
        center: Text("$minutes:$seconds",
            style: TextStyle(color: Colors.red, fontSize: 80.0)),
      ),
    );
  }
}

// 120 -->0
//0 .1 .2 .3. 4   1
class CounterBreakWidget extends StatelessWidget {
  final double time;
  final int fin;
  const CounterBreakWidget({
    Key key,
    @required this.time,
    @required this.fin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dr = Duration(seconds: time.toInt());
    final String minutes = (dr.inSeconds ~/ 60) > 9.9
        ? (dr.inSeconds ~/ 60).toString()
        : ("0" + (dr.inSeconds ~/ 60).toString());
    final String seconds = (dr.inSeconds.remainder(60) > 9.9
        ? dr.inSeconds.remainder(60).toString()
        : ("0" + dr.inSeconds.remainder(60).toString()));
    int tot = int.parse(minutes) * 60 + int.parse(seconds);

    percent = tot / fin;
    return Container(
      child: CircularPercentIndicator(
        percent: percent,
        animation: true,
        animateFromLastPercent: true,
        radius: 250.0,
        lineWidth: 20.0,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: Colors.green,
        center: Text("$minutes:$seconds",
            style: TextStyle(color: Colors.red, fontSize: 80.0)),
      ),
    );
  }
}

class CounterCompletedWidget extends StatelessWidget {
  final int rounds;

  const CounterCompletedWidget({
    Key key,
    @required this.rounds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: CircularPercentIndicator(
          percent: 1,
          animation: true,
          animateFromLastPercent: true,
          radius: 250.0,
          lineWidth: 20.0,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.green,
          center: Text("Completed",
              style: TextStyle(color: Colors.red, fontSize: 25.0)),
        ));
  }
}
