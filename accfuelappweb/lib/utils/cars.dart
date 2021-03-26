import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Map<String, List<String>> cars;

Future getCars() async {
  await Firebase.initializeApp();

  CollectionReference carsCollection = _firestore.collection('cars');

  cars = {'gt3': [], 'gt4': [], 'cup': [], 'st': []};

  var gt3 = await carsCollection.where('class', isEqualTo: 'GT3').get();
  gt3.docs.forEach((element) {
    cars['gt3'].add(element.data()['name']);
  });
  cars['gt3'].sort();

  var gt4 = await carsCollection.where('class', isEqualTo: 'GT4').get();
  gt4.docs.forEach((element) {
    cars['gt4'].add(element.data()['name']);
  });
  cars['gt4'].sort();

  var st = await carsCollection.where('class', isEqualTo: 'ST').get();
  st.docs.forEach((element) {
    cars['st'].add(element.data()['name']);
  });

  var cup = await carsCollection.where('class', isEqualTo: 'Cup').get();
  cup.docs.forEach((element) {
    cars['cup'].add(element.data()['name']);
  });
}
