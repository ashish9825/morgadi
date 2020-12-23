import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  fetchUserName() {
    return _firebaseAuth.currentUser.displayName ?? 'Name';
  }

  fetchUserPhoto() {
    return _firebaseAuth.currentUser.photoURL ?? 'Photo';
  }

  fetchUserPhone() {
    return _firebaseAuth.currentUser.phoneNumber ?? 'Not Found';
  }

  fetchUserEmail() {
    return _firebaseAuth.currentUser.email ?? 'Not Found';
  }

  Future<User> updateName(String name) async {
    var user = _firebaseAuth.currentUser;

    await user.updateProfile(displayName: name);
    await user.reload();

    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({'name': '$name'});

    return user;
  }

  Future<void> updateEmail(String email) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({'email': '$email'});
  }

  Future<void> updateCity(String city) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({'city': '$city'});
  }

  Future<void> updateOwnCar(bool ownCar) async {
    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({'ownCar': ownCar});
  }

  Future<User> updatePhone(String phoneNumber) async {
    var user = _firebaseAuth.currentUser;

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await user.updatePhoneNumber(credential);
        },
        verificationFailed: (Exception e) {
          print(e.toString());
        },
        codeSent: null,
        codeAutoRetrievalTimeout: null);

    await user.reload();

    return user;
  }

  Stream<DocumentSnapshot> fetchUserData() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Future<void> updatePhoneNumber(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);

    await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({'phoneNo': phoneNumber});
  }

  Future<User> verifyAndUpdatePhone(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await _firebaseAuth.currentUser.updatePhoneNumber(authCredential);

    return _firebaseAuth.currentUser;
  }

  Future<void> updateNumber(AuthCredential authCredential) async {
    var user = _firebaseAuth.currentUser;
    await _firebaseAuth.currentUser.updatePhoneNumber(authCredential);

    user.reload();
  }

  Future<User> getUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Stream<QuerySnapshot> fetchRentOrders() {
    return _firestore
        .collection('carRentRequests')
        .where('userId', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchRepairOrders() {
    return _firestore
        .collection('carRepairRequests')
        .where('userId', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchBuyOrders() {
    return _firestore
        .collection('carBuyRequests')
        .where('userId', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchSellOrders() {
    return _firestore
        .collection('carSellRequests')
        .where('userId', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchMortgageOrders() {
    return _firestore
        .collection('carMortgageRequests')
        .where('userId', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchSparePartOrders() {
    return _firestore
        .collection('carSparesRequests')
        .where('userId', isEqualTo: _firebaseAuth.currentUser.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot> fetchPrivacyPolicy() {
    return _firestore.collection('policies').doc('privacyPolicy').snapshots();
  }

  Stream<DocumentSnapshot> fetchAboutMorgadi() {
    return _firestore.collection('policies').doc('aboutMorgadi').snapshots();
  }

  Stream<DocumentSnapshot> fetchTermsAndConditions() {
    return _firestore.collection('policies').doc('termsAndConditions').snapshots();
  }

   Stream<DocumentSnapshot> fetchOpenSourceLicenses() {
    return _firestore.collection('policies').doc('openSourceLicenses').snapshots();
  }
}
