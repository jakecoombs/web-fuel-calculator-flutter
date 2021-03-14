import 'package:accfuelappweb/constants.dart';
import 'package:flutter/material.dart';

class ResponseSnackbar extends SnackBar {
  static showSnackbar(BuildContext context, String text,
      [bool success = true, Duration duration]) {
    final scaffold = Scaffold.of(context);
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);
    Color bgColor = Colors.red[700];

    if (!proVersion) {
      text = text + '\n\n';
    }

    if (success) {
      textStyle = TextStyle(fontSize: 18);
      bgColor = Colors.green;
    }

    scaffold.showSnackBar(SnackBar(
      content: Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      duration: duration ?? Duration(seconds: 4),
    ));
  }
}
