import 'package:accfuelappweb/components/buttons/base_button.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class CalculateButton extends StatelessWidget {
  CalculateButton({@required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: 'Calculate'.i18n,
      icon: Icons.calculate,
      onPressed: onPressed,
    );
  }
}
