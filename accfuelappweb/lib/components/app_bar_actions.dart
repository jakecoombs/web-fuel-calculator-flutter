import 'package:accfuelappweb/components/screens/calculator/calculator_screen.dart';
import 'package:accfuelappweb/components/screens/community/community_screen.dart';
import 'package:accfuelappweb/components/screens/settings/settings_screen.dart';
import 'package:accfuelappweb/utils/authentication.dart';
import 'package:accfuelappweb/widgets/auth_dialog.dart';
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
            PopupMenuItem(
              child: Text(
                userEmail == null ? 'Sign in'.i18n : 'Sign out'.i18n,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: 2,
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
              case 2:
                userEmail == null
                    ? showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      )
                    : () async {
                        await signOut().then((result) {
                          print(result);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => CalculatorScreen(),
                            ),
                          );
                        }).catchError((error) {
                          print('Sign Out Error: $error');
                        });
                      };
                break;
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Theme.of(context).scaffoldBackgroundColor,
        ));
  }
}
