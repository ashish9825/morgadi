import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RentRepository {
  final FirebaseAuth _firebaseAuth;

  RentRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> requestForCarRent(String carName, String source, String destination, String date,
      String time, String price, int distance, String timeStamp) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('carRentRequests').doc();

    return ref.set({
      'userId': _firebaseAuth.currentUser.uid,
      'carName': carName,
      'source': source,
      'destination': destination,
      'date': date,
      'time': time,
      'price': price,
      'distance': distance,
      'status': 'Pending',
      'timeStamp': timeStamp,
    });
  }
}
