import 'package:accfuelappweb/components/buttons/base_button.dart';
import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

class SaveButton extends StatelessWidget {
  SaveButton(
      {@required this.lapMinute,
      @required this.lapSecond,
      @required this.litresPerLap,
      @required this.car,
      @required this.conditons,
      @required this.track});
  final TextEditingController lapMinute, lapSecond, litresPerLap;
  final track, car, conditons;

  Future<Null> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String replacedTrack = track.replaceAll(' ', '');
    String replacedCar = car.replaceAll(' ', '');
    String trackCar = replacedTrack + replacedCar;
    if (conditons == 'Wet') {
      trackCar += conditons;
    }
    prefs.setStringList(trackCar, [
      lapMinute.text.toString(),
      lapSecond.text.toString(),
      litresPerLap.text.toString()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: 'Save'.i18n,
      icon: Icons.file_download,
      onPressed: () {
        if (lapMinute.text.isNotEmpty &&
            lapSecond.text.isNotEmpty &&
            litresPerLap.text.isNotEmpty) {
          saveData();
          ResponseSnackbar.showSnackbar(context, 'Saved'.i18n);
        } else {
          ResponseSnackbar.showSnackbar(context,
              'Error'.i18n + ': ' + 'Please fill in all values'.i18n, false);
        }
      },
    );
  }
}
