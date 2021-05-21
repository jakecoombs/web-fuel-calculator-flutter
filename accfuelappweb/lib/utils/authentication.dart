import 'package:accfuelappweb/utils/appData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

bool authSignedIn;
String uid;
String userEmail;

Future<String> registerWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    // Upload existing data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CollectionReference userDataCollection = _firestore.collection('userData');

    tracks.forEach((track) {
      cars.values.forEach((carsByClass) {
        carsByClass.forEach((car) async {
          String trackCar = track.replaceAll(' ', '') + car.replaceAll(' ', '');
          List<String> dryUserData = prefs.getStringList(trackCar);
          if (dryUserData != null) {
            await userDataCollection.add({
              'car': car,
              'track': track,
              'conditions': 'Dry',
              'litresPerLap': int.parse(dryUserData[2]),
              'minutes': int.parse(dryUserData[0]),
              'seconds': int.parse(dryUserData[1]),
              'milliseconds':
                  dryUserData.length >= 4 ? int.parse(dryUserData[3]) : 0,
              'userUid': uid
            });
          }
          List<String> wetUserData = prefs.getStringList(trackCar + 'Wet');
          if (wetUserData != null) {
            await userDataCollection.add({
              'car': car,
              'track': track,
              'conditions': 'Wet',
              'litresPerLap': int.parse(wetUserData[2]),
              'minutes': int.parse(wetUserData[0]),
              'seconds': int.parse(wetUserData[1]),
              'milliseconds':
                  wetUserData.length >= 4 ? int.parse(wetUserData[3]) : 0,
              'userUid': uid
            });
          }
        });
      });
    });

    return 'Successfully registered, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signInWithEmailPassword(String email, String password) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User user = userCredential.user;

  if (user != null) {
    // checking if uid or email is null
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    print(user.uid);

    return 'Successfully logged in, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}

Future resetPassword(String email) async {
  await _auth.sendPasswordResetEmail(email: email);
}

Future getUser() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool authSignedIn = prefs.getBool('auth') ?? false;

  final User user = _auth.currentUser;

  if (authSignedIn == true) {
    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
    }
  }
}

Future deleteUser() async {
  CollectionReference userDataCollection = _firestore.collection('userData');

  var dataToDelete = await userDataCollection
      .where('userUid', isEqualTo: _auth.currentUser.uid)
      .get();

  if (dataToDelete.docs.length > 0) {
    dataToDelete.docs.forEach((element) {
      userDataCollection.doc(element.id).delete();
    });
  }

  await _auth.currentUser.delete();
  userEmail = null;
  uid = null;
}
