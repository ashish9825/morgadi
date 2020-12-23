import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> sendOTP(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<UserCredential> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  Future<User> getUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }

  Future<User> getUpdatedUser(String name, String email) async {
    print('USER: ${_firebaseAuth.currentUser.uid}');
    var user = _firebaseAuth.currentUser;
    await user.updateProfile(displayName: name);
    await user.reload();

    return user;
  }

  Future<void> addUser(String name, String phoneNo, String email, String city,
      bool ownCar) async {
    print('USERID : ${_firebaseAuth.currentUser.uid}');
    // Call theh user's CollectionReference to add a new User;

    DocumentReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid);
    return users.set({
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'city': city,
      'ownCar': ownCar
    });
  }

  Future<bool> checkIfUserExists() async {
    try {
      // Get Reference to Firestore 'Users' Collection
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var userDoc =
          await collectionRef.doc(_firebaseAuth.currentUser.uid).get();
      return userDoc.exists;
    } catch (e) {
      throw e;
    }
  }
}
