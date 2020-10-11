import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morgadi/sections/carRentSection/model/car.dart';

class FirestoreProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

 carsAvailable(String source, String destination) async {
    List<Car> carsAvailable = [];

    // ignore: await_only_futures
    await FirebaseFirestore.instance
        .collection('carsForRent')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) async {
        // switch (element.data()['name']) {
        //   case 'Toyota Innova':
        //     {
        //       if (!carsAvailable.contains(element.data()['name'])) {
        //         int price = priceForACar('Toyota Innova', source, destination);
        //         carsAvailable.add(
        //           Car(
        //             element.data()['name'],
        //             element.data()['image'],
        //             price,
        //           ),
        //         );
        //       }
        //       break;
        //     }

        //   case 'Maruti Suzuki Ertiga':
        //     {

        //     }
        // }

        print('${element.data()['name']}');

        int price;

        await priceForACar(element.data()['name'], source, destination)
            .then((value) => price = value);

        print(
            'Cars : ${element.data()['name']} - ${element.data()['image']} - $price');
        await carsAvailable.add(
          Car(
            element.data()['name'],
            element.data()['image'],
            price,
          ),
        );
      });
    });

    return carsAvailable;
  }

  Future<int> priceForACar(
      String carName, String source, String destination) async {
    // Steps to retrieve perKm charges
    DocumentReference refPerKm =
        FirebaseFirestore.instance.collection('prices').doc('perKmPrice');

    DocumentSnapshot snapshotPerKm = await refPerKm.get();

    int pricePerKm = await snapshotPerKm.data()[carName];

    // Steps to retrieve convenience Charges
    DocumentReference refConv = FirebaseFirestore.instance
        .collection('prices')
        .doc('convenienceCharges');

    DocumentSnapshot snapshotConv = await refConv.get();

    int convCharge = await snapshotConv.data()[carName];

    //Steps to retrieve the distance between the source and destination
    DocumentReference refDist =
        FirebaseFirestore.instance.collection('distances').doc(source);

    DocumentSnapshot snapshotDist = await refDist.get();

    int distance = await snapshotDist.data()[destination];

    // print('${(pricePerKm * distance) + convCharge}');

    return (pricePerKm * distance) + convCharge;
  }

  void sampleFunction(String carName, String source, String destination) {
    // var dummyData = FirebaseFirestore.instance
    //     .collection('distances')
    //     .doc(source)
    //     .snapshots()
    //     .listen((event) {
    //   print('${event.data()[destination]}');
    // });

    var dummyData = FirebaseFirestore.instance
        .collection('prices')
        .doc('perKmPrice')
        .snapshots()
        .listen((event) => print(event.data()[carName]));

    // print('$dummyData');
  }
}
