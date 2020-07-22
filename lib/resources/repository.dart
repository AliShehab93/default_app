import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<bool> registerUser(Map userEntity) => // done with id
  _firestoreProvider.registerUser(userEntity);

  Stream<QuerySnapshot> getAllUsers() => _firestoreProvider.getAllUsers();
}