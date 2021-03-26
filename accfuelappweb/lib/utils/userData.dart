import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'authentication.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

String selectedTrack;
String selectedClass;
String selectedCar;
String selectedConditions;

List<Map<String, dynamic>> userData;

Future getUserData() async {
  await Firebase.initializeApp();

  CollectionReference userDataCollection = _firestore.collection('userData');

  if (uid != null) {
    var userDataResponse =
        await userDataCollection.where('userUid', isEqualTo: uid).get();

    if (userDataResponse.docs.length == 0) {
      userData = null;
      return;
    }

    userData = [];

    userDataResponse.docs.forEach((doc) {
      userData.add({
        'car': doc['car'],
        'track': doc['track'],
        'conditions': doc['conditions'],
        'litresPerLap': doc['litresPerLap'],
        'minutes': doc['minutes'],
        'seconds': doc['seconds'],
      });
    });

    print(userData);
  } else {
    userData = null;
  }
}

Future updateUserData(String car, String track, String conditions,
    double litresPerLap, int minutes, int seconds) async {
  await Firebase.initializeApp();

  CollectionReference userDataCollection = _firestore.collection('userData');

  if (uid != null) {
    userDataCollection.add({
      'car': car,
      'track': track,
      'conditions': conditions,
      'litresPerLap': litresPerLap,
      'minutes': minutes,
      'seconds': seconds,
      'userUid': uid
    });
  } else {
    throw Exception('User not logged in');
  }
}
