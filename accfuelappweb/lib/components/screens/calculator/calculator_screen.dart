import 'package:accfuelappweb/components/buttons/calculate_button.dart';
import 'package:accfuelappweb/components/buttons/save_button.dart';
import 'package:accfuelappweb/constants.dart';
import 'package:accfuelappweb/components/functions/data_checkbox.dart';
import 'package:accfuelappweb/components/functions/data_dropdown.dart';
import 'package:accfuelappweb/components/functions/break.dart';
import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:accfuelappweb/components/screens/calculator/functions/inputs.dart';
import 'package:accfuelappweb/components/screens/calculator/functions/outputs.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accfuelappweb/translations/translations.i18n.dart';

const double _xs = 320.0;
const double _s = 370.0;

class CalculatorScreen extends StatefulWidget {
  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<CalculatorScreen> {
  var lapMinute = TextEditingController();
  var lapSecond = TextEditingController();
  var stintLength = TextEditingController();
  var litresPerLap = TextEditingController();
  var riskyFuel = 0, safeFuel = 0;
  var formationLap = false;
  var car, track, carClass, classCars, trackConditions;
  ExpandableController modeController = ExpandableController();

  @override
  void initState() {
    super.initState();
    carClass = classData[0];
    classCars = carData[0];
    car = classCars[0];
    track = trackData[0];
    trackConditions = trackConditionsData[0];
    getSimpleMode();
    getFormation();
    initCombo();
    getData();
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
                litresPerLap: litresPerLap,
                stintLength: stintLength),
            Break(),
            Outputs(riskyFuel: riskyFuel, safeFuel: safeFuel),
            Break(
              height: 10,
            ),
            calculatorButtons()
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 50),
      ),
    );
  }

  Future<Null> initCombo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userData =
        prefs.getStringList('combo') ?? ['0', '0', '0', '0'];
    if (userData.length == 3) {
      userData.add('0');
    }
    setState(() {
      track = trackData[int.parse(userData[0])];
      carClass = classData[int.parse(userData[1])];
      classCars = carData[classData.indexOf(carClass)];
      car = classCars[int.parse(userData[2])];
      trackConditions = trackConditionsData[int.parse(userData[3])];
    });
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
                  items: trackConditionsData,
                  onChanged: (String conditions) {
                    setState(() {
                      trackConditions = conditions;
                    });
                    getDataAndSaveCombo();
                  },
                  value: trackConditions),
              Padding(padding: EdgeInsets.only(left: 5)),
              DataDropdown(
                items: trackData,
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
                items: classData,
                onChanged: (String newClass) {
                  setState(() {
                    carClass = newClass;
                    classCars = carData[classData.indexOf(carClass)];
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
          items: trackData,
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
              items: trackConditionsData,
              onChanged: (String conditions) {
                setState(() {
                  trackConditions = conditions;
                });
                getDataAndSaveCombo();
              },
              value: trackConditions,
              width: MediaQuery.of(context).size.width * 0.42,
            ),
            ConstrainedDataDropdown(
              items: classData,
              onChanged: (String newClass) {
                setState(() {
                  carClass = newClass;
                  classCars = carData[classData.indexOf(carClass)];
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
                litresPerLap: litresPerLap,
                car: car,
                track: track,
                conditons: trackConditions,
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
              litresPerLap: litresPerLap,
              car: car,
              track: track,
              conditons: trackConditions,
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
          int ls = int.parse(lapSecond.text);
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
          ResponseSnackbar.showSnackbar(context,
              'Error'.i18n + ': ' + 'Please fill in all values'.i18n, false);
        }
      });
    });
  }

  Future<Null> getDataAndSaveCombo() async {
    getData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String trackIndex = trackData.indexOf(track).toString();
    String classIndex = classData.indexOf(carClass).toString();
    String carIndex = classCars.indexOf(car).toString();
    String conditionsIndex =
        trackConditionsData.indexOf(trackConditions).toString();
    prefs.setStringList(
        'combo', [trackIndex, classIndex, carIndex, conditionsIndex]);
  }

  Future<Null> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String replacedTrack = track.replaceAll(' ', '');
    String replacedCar = car.replaceAll(' ', '');
    String trackCar = replacedTrack + replacedCar;
    if (trackConditions == 'Wet') {
      trackCar += trackConditions;
    }
    List<String> userData = prefs.getStringList(trackCar) ?? ['', '', ''];
    setState(() {
      lapMinute = new TextEditingController(text: userData[0]);
      lapSecond = new TextEditingController(text: userData[1]);
      litresPerLap = new TextEditingController(text: userData[2]);
    });
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
