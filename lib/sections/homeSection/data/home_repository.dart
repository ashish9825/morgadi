import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeRepository {
  final FirebaseAuth _firebaseAuth;
  final DateTime dateTime = DateTime.now();
  final TimeOfDay timeOfDay = TimeOfDay.now();

  final TimeOfDay morningTime = TimeOfDay(hour: 04, minute: 0);
  final TimeOfDay noonTime = TimeOfDay(hour: 12, minute: 00);
  final TimeOfDay eveningTime = TimeOfDay(hour: 17, minute: 00);
  final TimeOfDay nightTime = TimeOfDay(hour: 20, minute: 00);

  HomeRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  fetchUerName() {
    return _firebaseAuth.currentUser.displayName ?? 'Name';
  }

  currentDay() {
    String day = DateFormat('EEEE').format(dateTime);
    return day;
  }

  String currentTime() {
    if (toDouble(TimeOfDay.now()) >= toDouble(morningTime) &&
        toDouble(TimeOfDay.now()) < toDouble(noonTime)) {
      return 'Good Morning';
    } else if (toDouble(TimeOfDay.now()) >= toDouble(noonTime) &&
        toDouble(TimeOfDay.now()) < toDouble(eveningTime)) {
      return 'Good Afternoon';
    } else if (toDouble(TimeOfDay.now()) >= toDouble(eveningTime) &&
        toDouble(TimeOfDay.now()) < toDouble(nightTime)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  String timeIllustration() {
    if (currentTime().toString() == 'Good Morning' ||
        currentTime().toString() == 'Good Afternoon') {
      return 'assets/sun.json';
    } else {
      return 'assets/moon.json';
    }
  }

  Color timeColor() {
    if (currentTime() == 'Good Morning' || currentTime() == 'Good Afternoon') {
      return Color(0xFF0088cc);
    } else {
      return Color(0xFF1F132A);
    }
  }

  double toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print('SignOutError: ${e.toString()}');
      return null;
    }
  }
}
