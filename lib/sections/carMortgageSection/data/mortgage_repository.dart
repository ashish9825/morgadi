import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MortgageRepository {
  final FirebaseAuth _firebaseAuth;

  MortgageRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> requestForMortgage(String amount, String car, String model,
      String variant, String regNo, String originYear, String timeStamp) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('carMortgageRequests').doc();

    return ref.set({
      'userId': _firebaseAuth.currentUser.uid,
      'amount': amount,
      'car': car,
      'model': model,
      'variant': variant,
      'regNo': regNo,
      'originYear': originYear,
      'status': 'Pending',
      'timeStamp': timeStamp,
    });
  }
}
