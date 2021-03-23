import 'package:accfuelappweb/components/app_bar_actions.dart';
import 'package:accfuelappweb/components/app_bar.dart';
import 'package:accfuelappweb/components/screens/calculator/calculator_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

const String testDevice = null; //'efce9630-132d-41aa-8aa1-ad41c168402a';

class AppBase extends StatefulWidget {
  @override
  _Base createState() => _Base();
}

class _Base extends State<AppBase> {
  @override
  void initState() {
    super.initState();
    checkUserPrefs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> checkUserPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userTheme = prefs.getString('userTheme') ?? 'dark';
    switch (userTheme) {
      case 'light':
        AdaptiveTheme.of(context).setLight();
        break;
      case 'dark':
        AdaptiveTheme.of(context).setDark();
        break;
    }

    List<String> userLanguage = prefs.getStringList('language') ?? [];
    if (userLanguage.length == 1) {
      I18n.of(context).locale = Locale(userLanguage[0]);
    } else if (userLanguage.length == 2) {
      I18n.of(context).locale = Locale(userLanguage[0], userLanguage[1]);
    } else {
      I18n.of(context).locale = null;
    }
  }

  String getAppTitle() {
    return 'ACC ' + 'Fuel Calculator'.i18n;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: HomeAppBar(
              text: getAppTitle(),
            ),
            actions: [AppBarActions()],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        body: CalculatorScreen());
  }
}
