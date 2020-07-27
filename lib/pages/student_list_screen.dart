import 'package:EnsaAbs/model/presence.dart';
import 'package:EnsaAbs/model/student.dart';
import 'package:EnsaAbs/pages/details_screen.dart';
import 'package:EnsaAbs/service/classroom_service.dart';
import 'package:EnsaAbs/widgets/reusable_card.dart';
import 'package:EnsaAbs/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class StudentListScreen extends StatefulWidget {
  StudentListScreen({Key key, @required this.etudiants}) : super(key: key);
  final etudiants;
  static String id = 'student_list_screen';
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Presence> absences = [];
  bool isPresent = false;
  bool showSp=false;
  @override
  void initState() {
    print("heelo1");
    super.initState();
    print("heelo2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Students')),
        body: ModalProgressHUD(
                  inAsyncCall: showSp,
                  child: Center(
              child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: widget.etudiants
                      .map<Widget>((e) => ReusableCard(
                          onPress: () async {
                            List<Presence> presences =
                                await getPresencesByStudent(e.id);
                                Student std=await getStdById(e.id);
                                String name=std.firstName +" " +std.lastName;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(presences: presences,name:name),
                              ),
                            );
                          },
                          colour: kActiveCardColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(children: <Widget>[
                                SizedBox(width: 10),
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: CircleAvatar(
                                    backgroundColor: e.nAbsences>2?Colors.red:(e.nAbsences==2?Colors.yellow:Colors.green),
                                    radius: 10.0,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(e.firstName + " " + e.lastName),
                              ]),
                              Switch(
                                value: e.isPr,
                                onChanged: (value) {
                                  setState(() {
                                    e.isPr = value;
                                  });
                                },
                                activeColor: Colors.green,
                                activeTrackColor: Colors.lightGreenAccent,
                              )
                            ],
                          )))
                      .toList(),
                ),
              ),
              Container(
                height: 80,
                width: 400,
                child: StartButton(
                  colour: kButtomColor,
                  child: Text(
                    "Enregistrer l'absence",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPress: () async {
                    setState(() {
                      showSp=true;
                    });
                    try{
                      widget.etudiants.forEach((element) {
                      print(element.isPr);
                      
                      Presence p = new Presence.make(
                          null, element.isPr, DateTime.now(), null);
                      associatepToStd(element, p);
                      absences.add(p);
                      if(!element.isPr) {
                        element.nAbsences++;
                        updateStudent(element);
                      }
                    });
                    print("this is Id*************");
                    absences.forEach((element) {
                      print(element.studentId);
                    });
                   await addPresence(absences);
                    setState(() {
                      showSp=false;
                    });
                    
                    }catch(e){

                    }
                    
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
