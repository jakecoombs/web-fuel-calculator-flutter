import 'package:accfuelappweb/app_base.dart';
import 'package:accfuelappweb/components/app_theme.dart';
import 'package:accfuelappweb/translations/languages.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
  Iterable<Locale> getSupportedLanguages() {
    return Iterable<Locale>.generate(
        supportedLanguageCodes.length,
        (i) => (supportedLanguageCodes.values.toList()[i].length == 1
            ? Locale(supportedLanguageCodes.values.toList()[i][0])
            : Locale(supportedLanguageCodes.values.toList()[i][0],
                supportedLanguageCodes.values.toList()[i][1])));
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppTheme.lightTheme,
        dark: AppTheme.darkTheme,
        initial: AdaptiveThemeMode.dark,
        builder: (theme, darkTheme) => I18n(
              child: MaterialApp(
                title: 'ACC Fuel Calculator',
                debugShowCheckedModeBanner: false,
                theme: theme,
                darkTheme: darkTheme,
                home: I18n(child: SplashIntro()),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: getSupportedLanguages(),
              ),
            ));
  }
}

class SplashIntro extends StatelessWidget {
  String getAppTitle() {
    return 'ACC Fuel Calculator';
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new AppBase(),
      title: Text(
        getAppTitle(),
        style: Theme.of(context).textTheme.headline6,
      ),
      image: Image.asset('assets/fuel_pump.png'),
      photoSize: 100,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      loaderColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
