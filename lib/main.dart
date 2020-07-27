import 'package:EnsaAbs/pages/details_screen.dart';
import 'package:EnsaAbs/pages/landing_screen.dart';
import 'package:EnsaAbs/pages/student_list_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// This widget is the root of your application.
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF090c22),
          textTheme: TextTheme(
              //body1: TextStyle(color: Colors.black54),
              ),
        ),
        initialRoute: LandingScreen.id,
        routes: {
          LandingScreen.id: (context) => LandingScreen(),
          StudentListScreen.id: (context) => StudentListScreen(etudiants: null),
          DetailsScreen.id: (context) => DetailsScreen(
                presences: null,
              ),
        });
  }
}
