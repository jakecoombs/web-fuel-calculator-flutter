import 'package:accfuelappweb/components/functions/break.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({this.title, @required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Break(),
        Text(
          title.i18n,
          style: Theme.of(context).textTheme.headline6,
        ),
        child
      ],
    );
  }
}
