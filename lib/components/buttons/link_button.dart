import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  LinkButton(
      {@required this.text,
      @required this.url,
      @required this.bgColor,
      @required this.textColor});
  final String text;
  final String url;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
      color: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).accentColor, width: 1.5)),
    );
  }
}
