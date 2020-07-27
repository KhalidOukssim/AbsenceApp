import 'package:EnsaAbs/model/student.dart';
import 'package:flutter/material.dart';

class EtudiantCard extends StatelessWidget {
  EtudiantCard(
      {@required this.student, this.onChanged, @required this.isPresent});
  final Student student;
  final Function onChanged;
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: <Widget>[
            SizedBox(width: 10),
            Text(student.firstName + " " + student.lastName),
          ]),
          Switch(
            value: isPresent,
            onChanged: onChanged,
            activeColor: Colors.green,
            activeTrackColor: Colors.lightGreenAccent,
          )
        ]);
  }
}
