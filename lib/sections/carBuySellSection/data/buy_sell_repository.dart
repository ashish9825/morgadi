import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuySellRepository {
  final FirebaseAuth _firebaseAuth;

  BuySellRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> registerToSell(String car, String model, String variant,
      String regNo, String originYear, String timeStamp) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('carSellRequests').doc();

    return ref.set({
      'userId': _firebaseAuth.currentUser.uid,
      'car': car,
      'model': model,
      'variant': variant,
      'regNo': regNo,
      'originYear': originYear,
      'status': 'Pending',
      'timeStamp': timeStamp
    });
  }

  Future<void> interestedInBuying(String car, String model, String variant,
      String originYearRange, String timeStamp) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('carBuyRequests').doc();

    return ref.set({
      'userId': _firebaseAuth.currentUser.uid,
      'car': car,
      'model': model,
      'variant': variant,
      'originYearRange': originYearRange,
      'status': 'Pending',
      'timeStamp': timeStamp
    });
  }
}
