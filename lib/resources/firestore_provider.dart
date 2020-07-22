import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  /// register a user
  Future<bool> registerUser(Map<String, dynamic> userEntity) async {
    try {
      await _firestore.collection('users').add(userEntity);
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('registeredDate', descending: false)
        .snapshots();
  }
}
