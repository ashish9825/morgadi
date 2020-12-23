import 'package:cloud_firestore/cloud_firestore.dart';

class SparesProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  fetchCarModels(String carBrand) {
    return _firestore.collection('carBrands').doc(carBrand).snapshots();
  }
}
