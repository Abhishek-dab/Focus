import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Info {
  int freeTime;
  int workTime;
  bool checkTime;
  int sessions;

  Info({
    this.freeTime = 3,
    this.workTime = 57,
    this.checkTime = true,
    this.sessions = 3,
  });

  Map<String, dynamic> toMap() {
    return {
      'freeTime': freeTime,
      'workTime': workTime,
      'checkTime': checkTime,
      'sessions': sessions,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      freeTime: map['freeTime'],
      workTime: map['workTime'],
      checkTime: map['checkTime'],
      sessions: map['sessions'],
    );
  }
  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));

  Info copyWith({
    int freeTime,
    int workTime,
    bool checkTime,
    int sessions,
  }) {
    return Info(
      freeTime: freeTime ?? this.freeTime,
      workTime: workTime ?? this.workTime,
      checkTime: checkTime ?? this.checkTime,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  String toString() {
    return 'Info(freeTime: $freeTime, workTime: $workTime, checkTime: $checkTime, sessions: $sessions)';
  }
}

class SetData with ChangeNotifier {
  int currentSession = 0;
  Info info = Info();

  setInfo(Info infoUpdated) {
    if (info == infoUpdated) return;

    info = infoUpdated;
    notifyListeners();
  }

  setWorkTime() {
    info.checkTime = true;
    notifyListeners();
  }

  setFreeTime() {
    info.checkTime = false;
    notifyListeners();
  }

  setCurrentSessions(int updatedCurrentSessions) {
    if (currentSession == updatedCurrentSessions) return;

    currentSession = updatedCurrentSessions;
    notifyListeners();
  }
}
