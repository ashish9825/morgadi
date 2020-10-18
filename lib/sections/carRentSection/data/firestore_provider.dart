import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morgadi/sections/carRentSection/model/car.dart';
import 'package:morgadi/utils/constants.dart';

class FirestoreProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var carsAvailableList = List<Car>();

  Future<void> carsAvailable(String source, String destination) async {
    // _firestore.collection('carsForRent').snapshots().listen((event) {
    //   event.docs.forEach((element) async {
    //     int price;

    //     await priceForACar(element.data()['name'], source, destination)
    //         .then((value) {
    //       price = value;
    //       carsAvailableList.add(
    //         Car(
    //           name: element.data()['name'],
    //           image: element.data()['image'],
    //           price: price,
    //         ),
    //       );
    //     });
    //   });
    // });

    // _firestore.collection('carsForRent').get().then((value) async {
    //   int price;

    //   for (int i = 0; i < value.docs.length; i++) {
    //     await priceForACar(value.docs[i].data()['name'], source, destination)
    //         .then((priceValue) {
    //       price = priceValue;
    //       carsAvailableList.add(Car(
    //         name: value.docs[i].data()['name'],
    //         image: value.docs[i].data()['image'],
    //         price: price,
    //       ));
    //     });
    //   }
    // });
  }

  // Future<List<Car>> fetchCars(String source, String destination) async {
  //   await carsAvailable(source, destination);

  //   return carsAvailableList;
  // }

  Stream<QuerySnapshot> fetchCars(String source, String destination) {
    return _firestore.collection('carsForRent').snapshots();
  }

  String priceForRent(String source, String destination, String carName) {
    int price = (pricePerKm(carName) * distanceInKm(source, destination)) +
        convCharge(carName);

    return price.toString();
  }

  int pricePerKm(String carName) {
    int price;
    perKmCharges.forEach((key, value) {
      if (key == carName) {
        price = value;
      }
    });

    return price;
  }

  int convCharge(String carName) {
    int charge;
    convCharges.forEach((key, value) {
      if (key == carName) {
        charge = value;
      }
    });

    return charge;
  }

  int distanceInKm(String source, String destination) {
    int distance;

    switch (source) {
      case 'Bilaspur':
        {
          bilaspur.forEach((key, value) {
            if (key == destination) {
              distance = value;
            }
          });
          break;
        }
      case 'Champa':
        {
          champa.forEach((key, value) {
            if (key == destination) {
              distance = value;
            }
          });
          break;
        }
      case 'Korba':
        {
          korba.forEach((key, value) {
            if (key == destination) {
              distance = value;
            }
          });
          break;
        }
      case 'Raigarh':
        {
          raigarh.forEach((key, value) {
            if (key == destination) {
              distance = value;
            }
          });
          break;
        }
      case 'Raipur':
        {
          raipur.forEach((key, value) {
            if (key == destination) {
              distance = value;
            }
          });
          break;
        }
    }

    return distance;
  }

  Future<int> priceForACar(
      String carName, String source, String destination) async {
    // Steps to retrieve perKm charges
    DocumentReference refPerKm =
        _firestore.collection('prices').doc('perKmPrice');

    DocumentSnapshot snapshotPerKm = await refPerKm.get();

    int pricePerKm = await snapshotPerKm.data()[carName];

    // Steps to retrieve convenience Charges
    DocumentReference refConv =
        _firestore.collection('prices').doc('convenienceCharges');

    DocumentSnapshot snapshotConv = await refConv.get();

    int convCharge = await snapshotConv.data()[carName];

    //Steps to retrieve the distance between the source and destination
    DocumentReference refDist = _firestore.collection('distances').doc(source);

    DocumentSnapshot snapshotDist = await refDist.get();

    int distance = await snapshotDist.data()[destination];

    return (pricePerKm * distance) + convCharge;
  }
}
