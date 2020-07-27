import 'dart:io';
import 'package:EnsaAbs/service/classroom_service.dart';
import 'package:EnsaAbs/widgets/reusable_card.dart';
import 'package:EnsaAbs/widgets/start_button.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'classroom_list.dart';

class LandingScreen extends StatefulWidget {
  static String id = 'landing_screen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  /// The adapter
  File file;
  List etudiants = [];
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text("Bienvenue", style: kTitleLabel),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text("Gestion D'absence", style: kNumlabel),
                          Text(
                            'ENSAA',
                            style: kTextlabel,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StartButton(
                              colour: Color(0xFF4C4F5E),
                              child: Text(
                                "Start",
                                style: TextStyle(fontSize: 12.0),
                              ),
                              onPress: () async {
                                //List<Classroom> classes =
                                await getAllClassrooms().then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ClassroomList(classrooms: value),
                                    ),
                                  );
                                }).catchError((e) {
                                  print("error Man");
                                  print(e);

                                  _showDialog();
                                });
                              },
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            StartButton(
                                colour: Color(0xFF4C4F5E),
                                child: Text(
                                  "Choose a File",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                onPress: () async {
                                  file = await FilePicker.getFile();
                                  setState(() {
                                    if (file != null) showSpinner = true;
                                  });
                                  try {
                                    await insertNewFile(file);
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } catch (e) {}
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "@Khalid_Oukssim",
                        style: kSignatureLabel,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Alerte",
            style: TextStyle(color: Colors.red),
          ),
          content: new Text("Aucun fichier n'est Enregisté"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text("Retour"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
