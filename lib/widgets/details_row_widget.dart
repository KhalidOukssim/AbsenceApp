import 'package:EnsaAbs/model/presence.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'reusable_card.dart';

class DetailsRowWidget extends StatelessWidget {
  DetailsRowWidget({@required this.presence});
  final Presence presence;
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ReusableCard(
          colour: kActiveCardColor,
          child: Container(
              width: 120,
              height: 30,
              child: Center(
                child: presence.at != null
                    ? Text(
                        DateFormat('EEE d MMM y').format(presence.at)
                      )
                    : Text("null"),
              ))),
      SizedBox(
        width: 3,
      ),
      ReusableCard(
          colour: kActiveCardColor,
          child: Container(
            width: 70,
            height: 30,
            child: Center(
              child: presence.present
                  ? Text(
                      "Present",
                      style: TextStyle(color: Colors.green),
                    )
                  : Text(
                      "Absent",
                      style: TextStyle(color: Colors.red),
                    ),
            ),
          )),
      SizedBox(
        width: 3,
      ),
      ReusableCard(
          colour: kActiveCardColor,
          child: Container(
            width: 160,
            height: 30,
            child: Center(
              child: presence.note != null
                  ? Text(
                      presence.note,
                    )
                  : Text("Aucun Remarque"),
            ),
          )),
      SizedBox(
        width: 3,
      ),
    ]);
  }
}
