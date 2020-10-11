import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  void clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveBasicUserDetails(String city, String email, String name,
      bool ownCar, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("city", city);
    prefs.setString("email", email);
    prefs.setString("name", name);
    prefs.setBool("ownCar", ownCar);
    prefs.setString("phoneNo", phoneNumber);
  }

  getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");
    return name;
  }

  getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    return email;
  }

  getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String city = prefs.getString("city");
    return city;
  }

  getPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phone");
    return phone;
  }

  getOwnCar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ownCar = prefs.getBool("ownCar");
    return ownCar;
  }
}
