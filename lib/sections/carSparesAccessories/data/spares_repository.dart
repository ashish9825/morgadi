import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SparesRepository {
  final FirebaseAuth _firebaseAuth;

  SparesRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> requestForSpares(
      String partName,
      String car,
      String model,
      String otherCar,
      String variant,
      String originYear,
      String timeStamp) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('carSparesRequests').doc();

    return ref.set({
      'userId': _firebaseAuth.currentUser.uid,
      'partName': partName,
      'car': car,
      'model': model,
      'ifOtherCar': otherCar,
      'variant': variant,
      'originYear': originYear,
      'status': 'Pending',
      'timeStamp': timeStamp,
    });
  }
}
