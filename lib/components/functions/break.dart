import 'package:flutter/material.dart';

class Break extends StatelessWidget {
  Break({this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return Container(
        height: height,
      );
    } else {
      return Container(
        height: 20.0,
      );
    }
  }
}
