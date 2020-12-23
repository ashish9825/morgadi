import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepairRepository {
  final FirebaseAuth _firebaseAuth;

  RepairRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> requestForRepair(String carBrand, String carModel,
      String otherCar, String problem, String variant, String regNo, String timeStamp) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('carRepairRequests').doc();

    return ref.set({
      'userId': _firebaseAuth.currentUser.uid,
      'carBrand': carBrand,
      'carModel': carModel,
      'ifOtherCar': otherCar,
      'problem': problem,
      'variant': variant,
      'regNo': regNo,
      'status': 'Pending',
      'timeStamp': timeStamp,
    });
  }
}
