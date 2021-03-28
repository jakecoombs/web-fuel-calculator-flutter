import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'authentication.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future getUserData(String car, String track, String conditions) async {
  await Firebase.initializeApp();

  CollectionReference userDataCollection = _firestore.collection('userData');

  if (uid != null) {
    var userData = await userDataCollection
        .where('userUid', isEqualTo: uid)
        .where('car', isEqualTo: car)
        .where('track', isEqualTo: track)
        .where('conditions', isEqualTo: conditions)
        .limit(1)
        .get();

    if (userData.docs.length > 0) {
      return userData.docs[0].data();
    } else {
      print('No saved data');
      return null;
    }
  } else {
    print('User not logged in');
    return null;
  }
}

Future updateUserData(String car, String track, String conditions,
    double litresPerLap, int minutes, int seconds) async {
  await Firebase.initializeApp();

  CollectionReference userDataCollection = _firestore.collection('userData');

  if (uid != null) {
    var existingUserData = await userDataCollection
        .where('userUid', isEqualTo: uid)
        .where('car', isEqualTo: car)
        .where('track', isEqualTo: track)
        .where('conditions', isEqualTo: conditions)
        .limit(1)
        .get();

    //User has already saved data for this combo
    if (existingUserData.docs.length > 0) {
      await userDataCollection.doc(existingUserData.docs[0].id).update({
        'litresPerLap': litresPerLap,
        'minutes': minutes,
        'seconds': seconds,
      });
    } else {
      await userDataCollection.add({
        'car': car,
        'track': track,
        'conditions': conditions,
        'litresPerLap': litresPerLap,
        'minutes': minutes,
        'seconds': seconds,
        'userUid': uid
      });
    }
  } else {
    throw Exception('User not logged in');
  }
}
