import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class Outputs extends StatelessWidget {
  Outputs({@required this.riskyFuel, @required this.safeFuel});
  final int riskyFuel, safeFuel;

  Widget outputSection(BuildContext context, String text, int output) {
    return Column(
      children: [
        AutoSizeText(
          text.i18n,
          style: Theme.of(context).textTheme.bodyText2,
          maxLines: 1,
        ),
        SizedBox(
          child: Divider(
            color: Colors.white,
            height: 5,
            thickness: 1.5,
          ),
          width: 50,
        ),
        Text(
          output.toString() + ' L',
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(child: outputSection(context, 'Risky', riskyFuel)),
          SizedBox(
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1.5,
            ),
            width: 20,
            height: 40,
          ),
          Container(child: outputSection(context, 'Safe', safeFuel)),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.5, color: Theme.of(context).accentColor)),
      width: MediaQuery.of(context).size.width * 0.75,
      constraints: BoxConstraints(maxWidth: 400),
      padding: EdgeInsets.only(top: 2),
    );
  }
}
