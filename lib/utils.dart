import 'package:flutter/material.dart';
import 'package:focus/info_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:focus/statsUtil.dart';

const keyy = "SharedPreferences";

Future<void> counterOnFinished(BuildContext context) async {
  final info = Provider.of<SetData>(context, listen: false).info;

  Provider.of<SetData>(context, listen: false).setInfo(info.copyWith(
    checkTime: false,
  ));

  final currentSession =
      Provider.of<SetData>(context, listen: false).currentSession + 1;
  Provider.of<SetData>(context, listen: false)
      .setCurrentSessions(currentSession);

  await saveStatsTime(info);

  await Future.delayed(Duration(milliseconds: 240));
}

Future<void> breakCounterFinished(BuildContext context) async {
  final info = Provider.of<SetData>(context, listen: false).info;
  Provider.of<SetData>(context, listen: false).setInfo(info.copyWith(
    checkTime: true,
  ));
  await Future.delayed(Duration(milliseconds: 240));
}

Future<void> savePreferences(Info info) async {
  final instance = await SharedPreferences.getInstance();
  final toSave = info.toJson();

  await instance.setString(keyy, toSave);
}

Future<Info> getPreferences() async {
  final instance = await SharedPreferences.getInstance();
  final preferences = instance.getString(keyy);

  if (preferences == null) {
    await savePreferences(Info());
    return Info();
  }

  final info = Info.fromJson(preferences);
  return info;
}
