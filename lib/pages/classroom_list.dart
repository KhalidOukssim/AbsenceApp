import 'package:EnsaAbs/model/student.dart';
import 'package:EnsaAbs/pages/student_list_screen.dart';
import 'package:EnsaAbs/service/classroom_service.dart';
import 'package:EnsaAbs/widgets/classroom_widget.dart';
import 'package:EnsaAbs/widgets/reusable_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ClassroomList extends StatefulWidget {
  ClassroomList({Key key, @required this.classrooms}) : super(key: key);
  final classrooms;
  static String id = 'classroom_list';
  @override
  _ClassroomListState createState() => _ClassroomListState();
}

class _ClassroomListState extends State<ClassroomList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Classroom')),
      body: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          
          child: ListView(
            children:widget.classrooms
                .map<Widget>((e) => ReusableCard(
                    colour: kActiveCardColor,
                    child: ClassroomWidget(
                      classroom: e,
                    ),
                    onPress: ()async{
                      List<Student> etudiants= await getAllByclassName(e.id);
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StudentListScreen(etudiants: etudiants),
                                ),
                              );

                    },))
                .toList(),
        ),),
    );
  }
}

