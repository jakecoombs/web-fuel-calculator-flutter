import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Map<String, List<String>> cars;

Future getCars() async {
  await Firebase.initializeApp();

  CollectionReference carsCollection = _firestore.collection('cars');

  cars = {'GT3': [], 'GT4': [], 'Cup': [], 'ST': []};

  var gt3 = await carsCollection.where('class', isEqualTo: 'GT3').get();
  gt3.docs.forEach((element) {
    cars['GT3'].add(element.data()['name']);
  });
  cars['GT3'].sort();

  var gt4 = await carsCollection.where('class', isEqualTo: 'GT4').get();
  gt4.docs.forEach((element) {
    cars['GT4'].add(element.data()['name']);
  });
  cars['GT4'].sort();

  var st = await carsCollection.where('class', isEqualTo: 'ST').get();
  st.docs.forEach((element) {
    cars['ST'].add(element.data()['name']);
  });

  var cup = await carsCollection.where('class', isEqualTo: 'Cup').get();
  cup.docs.forEach((element) {
    cars['Cup'].add(element.data()['name']);
  });
}

String findCarClass(String carName) {
  var found = false;
  var carClass = '';
  cars.keys.forEach((key) {
    if (cars[key].contains(carName)) {
      found = true;
      carClass = key;
    }
  });
  return found ? carClass : null;
}
