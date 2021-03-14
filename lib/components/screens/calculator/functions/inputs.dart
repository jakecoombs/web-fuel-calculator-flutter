import 'package:accfuelappweb/components/functions/number_input.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class Inputs extends StatelessWidget {
  Inputs({
    @required this.lapMinute,
    @required this.lapSecond,
    @required this.litresPerLap,
    @required this.stintLength,
  });
  final TextEditingController lapMinute, lapSecond, litresPerLap, stintLength;

  Widget inputTitle(BuildContext context, String title) {
    return Expanded(
        child: AutoSizeText(
      title.i18n,
      maxLines: 1,
      style: Theme.of(context).textTheme.headline6,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              inputTitle(context, 'Lap Time'),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  NumberInput(
                    controller: lapMinute,
                    inputLength: 1,
                  ),
                  Text(
                    ' m   ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  NumberInput(controller: lapSecond, inputLength: 2),
                  Text(
                    ' s',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Container(
          child: Row(
            children: [
              inputTitle(context, 'Stint Length'),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  NumberInput(controller: stintLength, inputLength: 3),
                  Text(
                    ' m',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Container(
          child: Row(
            children: [
              inputTitle(context, 'Litres Per Lap'),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10)),
                  NumberInput(
                      controller: litresPerLap, inputLength: 4, decimal: true),
                  Text(
                    ' L',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ],
    );
  }
}
