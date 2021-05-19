import 'package:accfuelappweb/components/buttons/link_button.dart';
import 'package:accfuelappweb/components/functions/break.dart';
import 'package:flutter/material.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class SuggestionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Break(),
        Container(
          child: LinkButton(
            text: 'Send a suggestion'.i18n,
            url: 'https://forms.gle/3b75dArtWMBtt3PT7',
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          constraints: BoxConstraints(maxWidth: 450),
        )
      ],
    );
  }
}
