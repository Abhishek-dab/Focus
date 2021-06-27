import 'package:flutter/material.dart';
import 'package:focus/info_model.dart';
import 'package:provider/provider.dart';

class CheckBoxes extends StatelessWidget {
  const CheckBoxes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SetData>(builder: (context, state, _) {
      String title = state.info.checkTime ? "Work Time" : "Break Time";

      List<Widget> completedRounds = List.generate(
        state.currentSession,
        (index) => Icon(Icons.check_box, color: Colors.red),
      );

      List<Widget> sessions = List.generate(
        state.info.sessions - state.currentSession,
        (index) => Icon(
          Icons.check_box_outline_blank,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Row(
            children: completedRounds + sessions,
          )
        ],
      );
    });
  }
}
