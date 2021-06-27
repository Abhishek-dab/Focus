import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus/Widgets/bottomWidget.dart';
import 'package:focus/Widgets/counter.dart';
import 'package:focus/Widgets/checkBoxes.dart';
import 'package:focus/info_model.dart';
import 'package:focus/utils.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:audioplayers/audioplayers.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static AudioCache musicCache;
  static AudioPlayer instance;

  void playLoopedMusic() async {
    musicCache = AudioCache(prefix: "assets/");
    instance = await musicCache.loop("police.mp3");
    // await instance.setVolume(0.5); you can even set the volume
  }

  void pauseMusic() {
    if (instance != null) {
      instance.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = CountdownController();

    controller.pause(); // Width Pause

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.menu),
                ),
                onTap: () async {
                  try {
                    bool changes = await bottomWidget(
                      context,
                    );

                    // Wait For Changes
                    await Future.delayed(Duration(milliseconds: 300));

                    if (changes) {
                      controller.restart();
                      controller.pause();
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ),

          // Counter

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Connected to The Provider
              Consumer<SetData>(
                builder: (context, state, _) {
                  int durationInSeconds = state.info.workTime * 60;
                  int breakDurationInSeconds = state.info.freeTime * 60;

                  int currentRound = state.currentSession;

                  /// Finished Countdown
                  if (currentRound == state.info.sessions) {
                    // Returs Countdown because not to be memory leaks
                    return Countdown(
                      controller: controller,
                      seconds: durationInSeconds,
                      build: (BuildContext context, double time) {
                        controller.pause();

                        return CounterCompletedWidget(
                          rounds: currentRound,
                        );
                      },
                      interval: Duration(milliseconds: 100),
                    );
                  }

                  if (state.info.checkTime) {
                    /// Work Time Counter
                    return Countdown(
                      controller: controller,
                      seconds: durationInSeconds,
                      build: (BuildContext context, double time) {
                        /// Disable when initiiazed
                        if (durationInSeconds == time) {
                          controller.pause();
                        }
                        if (time == 0) {
                          playLoopedMusic();
                        }

                        return CounterWorkWidget(
                          time: time,
                          fin: durationInSeconds,
                        );
                      },
                      interval: Duration(milliseconds: 100),
                      onFinished: () async {
                        try {
                          await counterOnFinished(context);
                          controller.restart();
                        } catch (e) {
                          print(e);
                        }
                      },
                    );
                  }

                  /// Break Time Counter
                  else {
                    return Countdown(
                      controller: controller,
                      seconds: breakDurationInSeconds,
                      build: (BuildContext context, double time) {
                        /// Disable when initiiazed
                        if (breakDurationInSeconds == time) {
                          controller.pause();
                        }

                        return CounterBreakWidget(
                          time: time,
                          fin: durationInSeconds,
                        );
                      },
                      interval: Duration(milliseconds: 100),
                      onFinished: () async {
                        try {
                          await breakCounterFinished(context);
                          controller.restart();
                        } catch (e) {
                          print(e);
                        }
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 23),

              /// Current Round
              Positioned(
                child: CheckBoxes(),
              ),
            ],
          ),
          SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: new Icon(Icons.play_arrow),
                  onPressed: () {
                    controller.resume();
                  }),
              SizedBox(width: 20.0),
              FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: new Icon(Icons.stop),
                  onPressed: () {
                    controller.pause();
                  }),
              SizedBox(width: 20.0),
              FloatingActionButton(
                backgroundColor: Colors.blue,
                child: new Icon(Icons.refresh),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("Are You Sure To Restart?"),
                      actions: [
                        TextButton(
                          child: Text("Restart This Sesion"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            controller.restart();
                          },
                        ),
                        TextButton(
                          child: Text("Restart All"),
                          onPressed: () async {
                            try {
                              Navigator.of(context).pop();

                              // Set Round => 0
                              Provider.of<SetData>(context, listen: false)
                                  .setCurrentSessions(0);

                              // Set Work Time => true
                              Provider.of<SetData>(context, listen: false)
                                  .setWorkTime();

                              await Future.delayed(Duration(milliseconds: 200));
                              controller.restart();
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    barrierDismissible: true,
                  );
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: new Icon(Icons.alarm_off),
                  onPressed: () {
                    pauseMusic();
                  }),
              // Configure
            ],
          ),
        ],
      ),
    );
  }
}
