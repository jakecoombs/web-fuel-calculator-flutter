import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ScreenAppBar extends StatelessWidget {
  ScreenAppBar({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
    );
  }
}

class HomeAppBar extends StatelessWidget {
  HomeAppBar({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/fuel_pump.png',
          fit: BoxFit.fitHeight,
          height: 40.0,
        ),
        Padding(padding: EdgeInsets.only(left: 10)),
        Expanded(
          child: AutoSizeText(
            text,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
