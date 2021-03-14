import 'package:accfuelappweb/components/buttons/link_button.dart';
import 'package:accfuelappweb/constants.dart';
import 'package:accfuelappweb/components/functions/data_dropdown.dart';
import 'package:accfuelappweb/translations/languages.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationsSelection extends StatefulWidget {
  TranslationsSelection();

  @override
  _TranslationsSelectionState createState() => _TranslationsSelectionState();
}

class _TranslationsSelectionState extends State<TranslationsSelection> {
  ExpandableController translateOption = ExpandableController();

  @override
  void initState() {
    super.initState();
    getUserLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DataDropdown(
              items: supportedLanguages.values.toList(),
              onChanged: (String language) {
                String key = supportedLanguages.keys
                    .firstWhere(
                        (element) => supportedLanguages[element] == language)
                    .toString();
                if (key == 'sys') {
                  setState(() {
                    I18n.of(context).locale = null;
                    setLanguage([]);
                  });
                } else {
                  List<String> codes = supportedLanguageCodes[key].toList();
                  setState(() {
                    if (codes.length == 1) {
                      I18n.of(context).locale = Locale(codes[0]);
                    } else {
                      I18n.of(context).locale = Locale(codes[0], codes[1]);
                    }
                    setLanguage(codes);
                  });
                }
              },
              value: getLanguageValue()),
          Padding(padding: EdgeInsets.only(bottom: 5)),
          submitTranslationsSection(context)
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
    );
  }

  Future<Null> setLanguage(List<String> languageList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('language', languageList);
  }

  Future<Null> getUserLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userLanguage = prefs.getStringList('language') ?? [];
    if (userLanguage.length == 1) {
      I18n.of(context).locale = Locale(userLanguage[0]);
    } else if (userLanguage.length == 2) {
      I18n.of(context).locale = Locale(userLanguage[0], userLanguage[1]);
    } else {
      I18n.of(context).locale = null;
    }
  }

  getLanguageValue() {
    if (I18n.of(context).locale != null) {
      return supportedLanguages[I18n.localeStr];
    } else {
      return supportedLanguages['sys'];
    }
  }

  Widget submitTranslationsSection(BuildContext context) {
    return ExpandableNotifier(
      child: Container(
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            iconColor: Theme.of(context).colorScheme.primaryVariant,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Text(
            'Don\'t see your language?',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          expanded: Column(
            children: [
              Container(
                child: LinkButton(
                    text: 'Translate',
                    url: 'https://forms.gle/KMz4BbkR4GPqc9QMA',
                    bgColor: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.white),
                width: MediaQuery.of(context).size.width * 0.7,
                constraints: BoxConstraints(maxWidth: 450),
              ),
              !proVersion
                  ? Text(
                      'Send translations in your language and receive a free code for the pro version.',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    )
                  : Container(),
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        constraints: BoxConstraints(maxWidth: 450),
      ),
    );
  }
}
