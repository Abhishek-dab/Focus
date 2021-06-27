import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/info_model.dart';
import 'package:focus/utils.dart';
import 'package:provider/provider.dart';

Future<bool> bottomWidget(
  BuildContext context,
) async {
  var information = Provider.of<SetData>(context, listen: false).info;
  int sessions = information.sessions;
  int freeTime = information.freeTime;
  int workTime = information.workTime;

  bool changed = false;

  await showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.75,
      color: Colors.grey.shade200,
      child: StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 17,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RichText(
                  text: TextSpan(
                    text: "Rounds \n",
                    style: TextStyle(
                      color: Colors.blueGrey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "$sessions times",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              Expanded(
                child: Slider(
                  max: 10,
                  min: 1,
                  value: sessions.toDouble(),
                  divisions: 9,
                  activeColor: Color(0xFF60993E),
                  inactiveColor: Color(0xFF8D8E98),
                  onChanged: (double value) {
                    setState(() {
                      sessions = value.roundToDouble().toInt();
                    });
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Work Session \n",
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "       $workTime min",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Slider(
                  max: 60,
                  min: 1,
                  value: workTime.toDouble(),
                  divisions: 59,
                  activeColor: Color(0xFF60993E),
                  inactiveColor: Color(0xFF8D8E98),
                  onChanged: (double value) {
                    setState(() {
                      workTime = value.roundToDouble().toInt();
                    });
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Break Time\n",
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "    $freeTime min",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Slider(
                  max: 20,
                  min: 1,
                  value: freeTime.toDouble(),
                  divisions: 19,
                  activeColor: Color(0xFF60993E),
                  inactiveColor: Color(0xFF8D8E98),
                  onChanged: (double value) {
                    setState(() {
                      freeTime = value.roundToDouble().toInt();
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        color: Color(0xFF60993E),
                        child: Text(
                          "Don't Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          changed = false;
                        },
                      ),
                      RaisedButton(
                        color: Color(0xFF60993E),
                        child: Text(
                          "Save",
                          textScaleFactor: 1.15,
                        ),
                        onPressed: () async {
                          try {
                            final infoUpdated = information.copyWith(
                              freeTime: freeTime,
                              sessions: sessions,
                              workTime: workTime,
                              checkTime: true,
                            );

                            Provider.of<SetData>(context, listen: false)
                                .setCurrentSessions(0);

                            Provider.of<SetData>(context, listen: false)
                                .setInfo(infoUpdated);

                            await savePreferences(infoUpdated);

                            Navigator.pop(context);
                            changed = true;
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  return changed;
}
