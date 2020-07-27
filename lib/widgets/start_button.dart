import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  StartButton({this.colour, this.child, this.onPress});
  final Widget child;
  final Color colour;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return  FlatButton(
            color: colour,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding:
            EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
            splashColor: Colors.lightBlue,
            onPressed:onPress,
            child: child
          );
  }
}
