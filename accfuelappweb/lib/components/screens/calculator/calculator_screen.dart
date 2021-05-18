import 'dart:math';

import 'package:accfuelappweb/components/buttons/calculate_button.dart';
import 'package:accfuelappweb/components/buttons/save_button.dart';
import 'package:accfuelappweb/components/functions/data_checkbox.dart';
import 'package:accfuelappweb/components/functions/data_dropdown.dart';
import 'package:accfuelappweb/components/functions/break.dart';
import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:accfuelappweb/components/screens/calculator/functions/inputs.dart';
import 'package:accfuelappweb/components/screens/calculator/functions/outputs.dart';
import 'package:accfuelappweb/utils/appData.dart';
import 'package:accfuelappweb/utils/userData.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';
import 'package:url_launcher/url_launcher.dart';

const double _xs = 320.0;
const double _s = 370.0;

class CalculatorScreen extends StatefulWidget {
  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<CalculatorScreen> {
  var lapMinute = TextEditingController();
  var lapSecond = TextEditingController();
  var lapMillisecond = TextEditingController();
  var stintLength = TextEditingController();
  var litresPerLap = TextEditingController();
  var riskyFuel = 0, safeFuel = 0;
  var formationLap = false;
  var car, track, carClass, classCars, trackCondition;
  ExpandableController modeController = ExpandableController();

  Future initCalculator() async {
    trackCondition = trackConditions[0];
    getSimpleMode();
    getFormation();
    await initCombo();
    await getData();
    setState(() {});
  }

  @override
  void initState() {
    initCalculator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            dataOptions(),
            Inputs(
                lapMinute: lapMinute,
                lapSecond: lapSecond,
                lapMillisecond: lapMillisecond,
                litresPerLap: litresPerLap,
                stintLength: stintLength),
            Break(),
            Outputs(riskyFuel: riskyFuel, safeFuel: safeFuel),
            Break(
              height: 10,
            ),
            calculatorButtons(),
            Break(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                var url =
                    'https://play.google.com/store/apps/details?id=com.accfuelcalc.accfuelcalculator&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Container(
                child: ClipRRect(
                  child: Image.asset('assets/googlePlayBadge.png'),
                ),
              ),
            ),
            Break(),
            InkWell(
              onTap: () async {
                var url =
                    'https://apps.apple.com/us/app/acc-fuel-calculator/id1540153714?itsct=apps_box&amp;itscg=30200';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Container(
                child: ClipRRect(
                  child: Image.asset('assets/appStoreBadge.png'),
                ),
              ),
            )
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 50),
      ),
    );
  }

  Future<Null> initCombo() async {
    await initData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userData =
        prefs.getStringList('combo') ?? ['0', '0', '0', '0'];
    if (userData.length == 3) {
      userData.add('0');
    }
    if (int.parse(userData[1]) == 0 &&
        int.parse(userData[2]) > cars['GT3'].length) {
      // Out of bounds
      setState(() {
        track = tracks[int.parse(userData[0])];
        carClass = 'GT3';
        classCars = cars['GT3'];
        car = cars['GT3'][0];
        trackCondition = trackConditions[int.parse(userData[3])];
      });
    } else {
      setState(() {
        track = tracks[int.parse(userData[0])];
        carClass = cars.keys.toList()[int.parse(userData[1])];
        classCars = cars[carClass];
        car = classCars[int.parse(userData[2])];
        trackCondition = trackConditions[int.parse(userData[3])];
      });
    }
  }

  Widget dataOptions() {
    Widget options = dataOptionsStandard();
    if (MediaQuery.of(context).size.width < _s) {
      options = dataOptionsSmall();
    }
    return ExpandableNotifier(
      child: Container(
        child: Column(
          children: [
            Expandable(
              expanded: options,
              collapsed: Container(),
              controller: modeController,
            ),
            Container(
              child: checkboxes(),
              padding: EdgeInsets.symmetric(horizontal: 5),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        padding: EdgeInsets.only(top: 5),
      ),
    );
  }

  Widget dataOptionsStandard() {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataDropdown(
                  items: trackConditions,
                  onChanged: (String conditions) {
                    setState(() {
                      trackCondition = conditions;
                    });
                    getDataAndSaveCombo();
                  },
                  value: trackCondition),
              Padding(padding: EdgeInsets.only(left: 5)),
              DataDropdown(
                items: tracks,
                onChanged: (String newTrack) {
                  setState(() {
                    track = newTrack;
                  });
                  getDataAndSaveCombo();
                },
                value: track,
              ),
              Padding(padding: EdgeInsets.only(left: 5)),
              DataDropdown(
                items: cars != null ? cars.keys.toList() : [],
                onChanged: (String newClass) {
                  setState(() {
                    carClass = newClass;
                    classCars = cars[newClass];
                    car = classCars[0];
                  });
                  getDataAndSaveCombo();
                },
                value: carClass,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        Container(
          child: DataDropdown(
            items: classCars,
            onChanged: (String newCar) {
              setState(() {
                car = newCar;
              });
              getDataAndSaveCombo();
            },
            value: car,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ],
    );
  }

  Widget dataOptionsSmall() {
    return Column(
      children: [
        ConstrainedDataDropdown(
          items: tracks,
          onChanged: (String newTrack) {
            setState(() {
              track = newTrack;
            });
            getDataAndSaveCombo();
          },
          value: track,
        ),
        Row(
          children: [
            ConstrainedDataDropdown(
              items: trackConditions,
              onChanged: (String conditions) {
                setState(() {
                  trackCondition = conditions;
                });
                getDataAndSaveCombo();
              },
              value: trackCondition,
              width: MediaQuery.of(context).size.width * 0.42,
            ),
            ConstrainedDataDropdown(
              items: cars.keys,
              onChanged: (String newClass) {
                setState(() {
                  carClass = newClass;
                  classCars = cars[newClass];
                  car = classCars[0];
                });
                getDataAndSaveCombo();
              },
              value: carClass,
              width: MediaQuery.of(context).size.width * 0.42,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        ConstrainedDataDropdown(
          items: classCars,
          onChanged: (String newCar) {
            setState(() {
              car = newCar;
            });
            getDataAndSaveCombo();
          },
          value: car,
        ),
      ],
    );
  }

  Widget checkboxes() {
    if (MediaQuery.of(context).size.width < _xs) {
      return Column(
        children: [formationLapCheckbox(), modeCheckbox()],
      );
    } else if (MediaQuery.of(context).size.width < _s) {
      return Row(
        children: [
          SizedBox(
            child: formationLapCheckbox(true),
            width: MediaQuery.of(context).size.width * 0.52,
          ),
          SizedBox(
            child: modeCheckbox(true),
            width: MediaQuery.of(context).size.width * 0.33,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    } else {
      return Row(
        children: [
          formationLapCheckbox(),
          Padding(padding: EdgeInsets.only(left: 5)),
          modeCheckbox()
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }
  }

  Widget formationLapCheckbox([bool constrained = false]) {
    return Container(
      child: DataCheckbox(
        text: 'Formation Lap'.i18n,
        value: formationLap,
        onCheckboxSelected: () {
          setState(() {
            formationLap = !formationLap;
            setFormation();
          });
        },
        constrained: constrained,
      ),
      padding: EdgeInsets.only(bottom: 5),
    );
  }

  Widget modeCheckbox([bool constrained = false]) {
    return Builder(
      builder: (context) {
        return Container(
          child: DataCheckbox(
            text: 'Simple'.i18n,
            value: !modeController.expanded,
            onCheckboxSelected: () {
              setState(() {
                setSimpleMode();
              });
              modeController.toggle();
            },
            constrained: constrained,
          ),
          padding: EdgeInsets.only(bottom: 5),
        );
      },
    );
  }

  Widget calculatorButtons() {
    if (MediaQuery.of(context).size.width < _s) {
      return Column(
        children: [
          calculateButton(),
          Expandable(
            controller: modeController,
            expanded: Container(
              child: SaveButton(
                lapMinute: lapMinute,
                lapSecond: lapSecond,
                lapMillisecond: lapMillisecond,
                litresPerLap: litresPerLap,
                car: car,
                track: track,
                conditions: trackCondition,
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expandable(
          controller: modeController,
          expanded: Container(
            child: SaveButton(
              lapMinute: lapMinute,
              lapSecond: lapSecond,
              lapMillisecond: lapMillisecond,
              litresPerLap: litresPerLap,
              car: car,
              track: track,
              conditions: trackCondition,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
        ),
        calculateButton()
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget calculateButton() {
    return CalculateButton(onPressed: () {
      setState(() {
        if (lapMinute.text.isNotEmpty &&
            lapSecond.text.isNotEmpty &&
            stintLength.text.isNotEmpty &&
            litresPerLap.text.isNotEmpty) {
          int lm = int.parse(lapMinute.text);
          double ls = double.parse(lapSecond.text);

          if (lapMillisecond.text.isNotEmpty) {
            ls += double.parse(lapMillisecond.text) /
                pow(10, lapMillisecond.text.length);
          }

          int sl = int.parse(stintLength.text);
          double lpl = double.parse(litresPerLap.text);
          double lt = lm + (ls / 60);
          double laps = sl / lt;

          int rf = (laps * lpl).ceil();
          int sf = (rf + lpl).ceil();
          if (formationLap) {
            rf = sf;
            sf = (sf + lpl).ceil();
          }

          safeFuel = sf;
          riskyFuel = rf;
        } else {
          ResponseSnackbar.showSnackbar(
              context, 'Error'.i18n + ': ' + 'Please fill in all values'.i18n,
              success: false);
        }
      });
    });
  }

  Future<Null> getDataAndSaveCombo() async {
    getData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String trackIndex = tracks.indexOf(track).toString();
    String classIndex = cars.keys.toList().indexOf(carClass).toString();
    String carIndex = classCars.indexOf(car).toString();
    String conditionsIndex = trackConditions.indexOf(trackCondition).toString();
    prefs.setStringList(
        'combo', [trackIndex, classIndex, carIndex, conditionsIndex]);
  }

  Future<Null> getData() async {
    var cloudData = await getUserData(car, track, trackCondition);
    if (cloudData == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String replacedTrack = track.replaceAll(' ', '');
      String replacedCar = car.replaceAll(' ', '');
      String trackCar = replacedTrack + replacedCar;
      if (trackCondition == 'Wet') {
        trackCar += trackCondition;
      }
      List<String> userData = prefs.getStringList(trackCar) ?? ['', '', '', ''];
      setState(() {
        lapMinute = new TextEditingController(text: userData[0]);
        lapSecond = new TextEditingController(text: userData[1]);
        litresPerLap = new TextEditingController(text: userData[2]);
        lapMillisecond = new TextEditingController(
            text: userData.length >= 4 ? userData[3] : '');
      });
    } else {
      setState(() {
        lapMinute =
            new TextEditingController(text: cloudData['minutes'].toString());
        lapSecond =
            new TextEditingController(text: cloudData['seconds'].toString());
        litresPerLap = new TextEditingController(
            text: cloudData['litresPerLap'].toString());
        lapMillisecond = new TextEditingController(
            text: cloudData['milliseconds'].toString());
      });
    }
  }

  Future<Null> getSimpleMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userPref = prefs.getBool('simple') ?? false;
    setState(() {
      if (userPref == modeController.expanded) {
        modeController.toggle();
      }
    });
  }

  Future<Null> setSimpleMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('simple', !modeController.expanded);
  }

  Future<Null> getFormation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userPref = prefs.getBool('formation') ?? false;
    setState(() {
      formationLap = userPref;
    });
  }

  Future<Null> setFormation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('formation', formationLap);
  }
}
