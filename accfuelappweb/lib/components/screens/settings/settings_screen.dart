import 'package:accfuelappweb/components/app_bar.dart';
import 'package:accfuelappweb/components/buttons/link_button.dart';
import 'package:accfuelappweb/components/functions/break.dart';
import 'package:accfuelappweb/components/screens/settings/functions/settings_section.dart';
import 'package:accfuelappweb/components/screens/settings/functions/suggestions_section.dart';
import 'package:accfuelappweb/components/screens/settings/functions/translations_selection.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _Preferences createState() => _Preferences();
}

class _Preferences extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SettingsSection(
                  child: TranslationsSelection(),
                  title: 'Language',
                ),
                SuggestionsSection(),
                Break(),
                Container(
                  child: LinkButton(
                      text: 'Changelog',
                      url: 'https://www.acc-fuel-calculator.com/changelog',
                      bgColor: Theme.of(context).colorScheme.secondary,
                      textColor: Colors.white),
                  width: MediaQuery.of(context).size.width * 0.7,
                  constraints: BoxConstraints(maxWidth: 450),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 60),
            alignment: Alignment.center,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: ScreenAppBar(text: 'Settings'.i18n),
            centerTitle: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
