import 'package:EnsaAbs/model/presence.dart';
import 'package:EnsaAbs/service/classroom_service.dart';
import 'package:EnsaAbs/widgets/details_row_widget.dart';
import 'package:EnsaAbs/widgets/reusable_card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key, @required this.presences,this.name}) : super(key: key);
  final presences;
  final name;
  static String id = 'details_screen';
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Presence> presences = widget.presences;
    return Scaffold(
        appBar: AppBar(title: Text('Detail de '+widget.name)),
        body: Center(
            child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              ReusableCard(
                  colour: kActiveCardColor,
                  child: Container(
                    width: 120,
                    height: 30,
                    child: Center(
                      child: Text(
                        'Date!',
                      ),
                    ),
                  )),
              SizedBox(
                width: 3,
              ),
              ReusableCard(
                  colour: kActiveCardColor,
                  child: Container(
                    width: 70,
                    height: 30,
                    child: Center(
                      child: Text(
                        'Etat!',
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
                      child: Text(
                        'Observetion!',
                      ),
                    ),
                  )),
              SizedBox(
                width: 3,
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: presences.length,
                  itemBuilder: (context, int index) => new Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) async {
                        presences.removeAt(index);
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("date deleted"),
                        ));
                        await removePresence(presences[index].id);
                      },
                      background: new Container(
                          child: Icon(Icons.delete_forever), color: Colors.red),
                      child: DetailsRowWidget(presence: presences[index])))),
        ])));

    //_projects.map((e) => Expanded(child: DetailsRowWidget())).toList(),
  }
}
// //
