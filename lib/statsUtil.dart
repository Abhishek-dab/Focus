import 'package:focus/info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveStatsTime(Info toAddInfo) async {
  final instance = await SharedPreferences.getInstance();
  final today = DateTime.now();
  final todayKey = today.month.toString() +
      "-" +
      today.day.toString() +
      "-" +
      today.year.toString();

  final todayWorkTime = await getStatsToday() + toAddInfo.workTime;
  await instance.setInt(todayKey, todayWorkTime);
}

Future<int> getStatsToday() async {
  final instance = await SharedPreferences.getInstance();
  final today = DateTime.now();
  final todayKey = today.month.toString() +
      "-" +
      today.day.toString() +
      "-" +
      today.year.toString();
  final todayStatsTime = instance.getInt(todayKey);
  if (todayStatsTime == null) {
    return 0;
  } else {
    return todayStatsTime;
  }
}

Future<int> getStatsYesterday() async {
  final instance = await SharedPreferences.getInstance();
  final yesterday = DateTime.now().subtract(Duration(days: 1));
  final yesterdayKey = yesterday.month.toString() +
      "-" +
      yesterday.day.toString() +
      "-" +
      yesterday.year.toString();
  final yesterdayStatsTime = instance.getInt(yesterdayKey);
  if (yesterdayStatsTime == null) {
    return 0;
  } else {
    return yesterdayStatsTime;
  }
}

Future<List<int>> getStatsWeek() async {
  final instance = await SharedPreferences.getInstance();
  List<int> days = [];

  for (int i = 0; i < 7; i++) {
    final today = DateTime.now().subtract(Duration(days: i));
    final todayKey = today.month.toString() +
        "-" +
        today.day.toString() +
        "-" +
        today.year.toString();
    final todayStatsTime = instance.getInt(todayKey);

    if (todayStatsTime == null) {
      days.add(0);
      await instance.setInt(todayKey, 0);
    } else {
      days.add(todayStatsTime);
    }
  }

  return days;
}
