import 'package:accfuelappweb/components/screens/community/community_screen.dart';
import 'package:accfuelappweb/components/screens/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class AppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                'Community'.i18n,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: 0,
            ),
            PopupMenuItem(
              child: Text(
                'Settings'.i18n,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: 1,
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 0:
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => CommunityScreen()));
                break;
              case 1:
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SettingsScreen()));
                break;
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Theme.of(context).scaffoldBackgroundColor,
        ));
  }
}
