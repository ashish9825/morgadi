import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String name;
  final String image;

  Car({this.name, this.image});

  factory Car.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();

    return Car(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
