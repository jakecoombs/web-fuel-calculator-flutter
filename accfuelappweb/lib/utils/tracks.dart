import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

List<String> tracks;

Future getTracks() async {
  await Firebase.initializeApp();

  CollectionReference tracksCollection = _firestore.collection('tracks');

  tracks = [];
  var tracksData = await tracksCollection.get();
  tracksData.docs.forEach((element) {
    tracks.add(element.data()['name']);
  });
  tracks.sort();
}
