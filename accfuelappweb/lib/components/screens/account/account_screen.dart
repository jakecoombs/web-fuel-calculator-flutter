import 'package:accfuelappweb/components/app_bar.dart';
import 'package:accfuelappweb/components/buttons/base_button.dart';
import 'package:accfuelappweb/components/functions/break.dart';
import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:accfuelappweb/utils/authentication.dart';
import 'package:accfuelappweb/widgets/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Break(),
                Text(userEmail),
                Break(),
                BaseButton(
                  text: 'Sign Out',
                  onPressed: () {
                    signOut().catchError((error) {
                      ResponseSnackbar.showSnackbar(
                          context, 'Sign Out Error: $error');
                    });
                    Navigator.pop(context);
                  },
                ),
                Break(),
                BaseButton(
                  text: 'Change Password',
                  onPressed: () {
                    resetPassword(userEmail).then((result) {
                      ResponseSnackbar.showSnackbar(
                          context,
                          'An email has been sent to ' +
                              userEmail +
                              ' to change your password',
                          duration: Duration(seconds: 8));
                    }).catchError((error) {
                      ResponseSnackbar.showSnackbar(context, 'Error: $error',
                          success: false, duration: Duration(seconds: 5));
                    });
                  },
                ),
                Break(),
                BaseButton(
                    text: 'Delete Account',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => ConfirmDeleteDialog());
                    })
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 50),
            alignment: Alignment.center,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: ScreenAppBar(text: 'Account'.i18n),
            centerTitle: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
