import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DataCheckbox extends StatelessWidget {
  DataCheckbox(
      {@required this.text,
      @required this.value,
      @required this.onCheckboxSelected,
      this.constrained});
  final String text;
  final bool value;
  final VoidCallback onCheckboxSelected;
  final bool constrained;

  Widget textChild(BuildContext context) {
    if (constrained) {
      return Expanded(
        child: AutoSizeText(
          text,
          style: Theme.of(context).textTheme.headline2,
          maxLines: 1,
          minFontSize: 10,
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150),
        child: AutoSizeText(
          text,
          style: Theme.of(context).textTheme.headline2,
          maxLines: 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {
                onCheckboxSelected();
              },
              activeColor: Colors.white,
              checkColor: Theme.of(context).colorScheme.secondary,
            ),
            textChild(context)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        padding: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(width: 1.5, color: Theme.of(context).accentColor)),
        height: 40,
      ),
      onTap: () {
        onCheckboxSelected();
      },
    );
  }
}
