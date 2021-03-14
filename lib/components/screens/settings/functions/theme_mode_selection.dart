import 'package:accfuelappweb/components/functions/break.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class ThemeModeSelection extends StatefulWidget {
  ThemeModeSelection({Key key}) : super(key: key);

  @override
  _ThemeModeSelectionState createState() => _ThemeModeSelectionState();
}

class _ThemeModeSelectionState extends State<ThemeModeSelection> {
  bool useSystemMode = false;

  @override
  void initState() {
    super.initState();
    useSystemMode = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system;
  }

  Future<Null> setThemeMode(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userTheme', mode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Break(
            height: 5,
          ),
          Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 5)),
                Expanded(
                  child: AutoSizeText(
                    'Dark Mode'.i18n.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                Switch(
                  value:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                  onChanged: (value) {
                    if (!useSystemMode) {
                      AdaptiveTheme.of(context).toggleThemeMode();
                      if (AdaptiveTheme.of(context).mode ==
                          AdaptiveThemeMode.dark) {
                        setThemeMode('dark');
                      } else {
                        setThemeMode('light');
                      }
                    } else {
                      useSystemMode = false;
                      if (MediaQuery.of(context).platformBrightness ==
                          Brightness.dark) {
                        AdaptiveTheme.of(context).setLight();
                      } else {
                        AdaptiveTheme.of(context).setDark();
                      }
                    }
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(width: 1.5, color: Theme.of(context).accentColor),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 40,
            constraints: BoxConstraints(maxWidth: 450),
          ),
          Break(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 5)),
                Expanded(
                  child: AutoSizeText(
                    'system default theme'.i18n.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                Switch(
                  value: useSystemMode,
                  onChanged: (value) {
                    useSystemMode = !useSystemMode;
                    if (useSystemMode) {
                      setThemeMode('system');
                      AdaptiveTheme.of(context).setSystem();
                    } else {
                      setThemeMode('light');
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(width: 1.5, color: Theme.of(context).accentColor),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 40,
            constraints: BoxConstraints(maxWidth: 450),
          ),
        ],
      ),
    );
  }
}
