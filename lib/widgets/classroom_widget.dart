import 'package:EnsaAbs/model/classroom.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ClassroomWidget extends StatelessWidget {
  ClassroomWidget({@required this.classroom});
  final Classroom classroom;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
                backgroundColor: kThirdButtomColor,
                radius: 25.0,
                child: Text(
                  _subText(classroom.className),
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                )),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      classroom.className,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Text((classroom.nStudents).toString() + " etudiants"),
              SizedBox(width: 8)
            ]),
            SizedBox(height: 30)
          ],
        ),
      ],
    );
  }
}

_subText(String text) {
  return text.substring(0, 1);
}
