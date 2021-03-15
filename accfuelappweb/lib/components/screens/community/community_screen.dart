import 'package:accfuelappweb/components/functions/break.dart';
import 'package:accfuelappweb/components/buttons/link_button.dart';
import 'package:accfuelappweb/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Container(
              child: Column(
                children: [
                  Break(),
                  Text('Twitch'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6),
                  Container(
                    child: LinkButton(
                        text: 'twitch.tv/itsthesink',
                        url: 'https://www.twitch.tv/itsthesink',
                        bgColor: Colors.purple,
                        textColor: Colors.white),
                    width: MediaQuery.of(context).size.width * 0.7,
                    constraints: BoxConstraints(maxWidth: 450),
                  ),
                  Break(
                    height: 40,
                  ),
                  Text('Discord Communities'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6),
                  Container(
                    child: LinkButton(
                        text: 'Slipstream Racing',
                        url: 'https://discord.gg/hWaKvmX',
                        bgColor: Colors.red,
                        textColor: Colors.white),
                    width: MediaQuery.of(context).size.width * 0.7,
                    constraints: BoxConstraints(maxWidth: 450),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 50),
            alignment: Alignment.center,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: ScreenAppBar(text: 'Community'.i18n),
            centerTitle: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ));
  }
}
