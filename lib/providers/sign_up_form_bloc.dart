import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:kuwait_test/models/users_model.dart';
import 'package:kuwait_test/resources/repository.dart';

class SignUpFormProvider with ChangeNotifier {
  final _repository = Repository();
  bool validatingStatus = false;
  bool isLoading = false;
  List<UsersModel> usersList = [];

  // list of gender list
  List<String> genderList = ['Choose Your Gender', 'Male', 'Female'];
  String genderDefaultValue = 'Choose Your Gender';
  String genderfixedValue = 'Choose Your Gender';

  // list of nationality list
  List<String> nationalityList = [
    'Choose Your Nationality',
    'Togo',
    'Lebanon',
    'Nigeria',
    'Niger',
    'France',
    'China',
    'Malian'
  ];
  String nationalityDefaultValue = 'Choose Your Nationality';
  String nationalityFixedValue = 'Choose Your Nationality';

  String fixedDateOfBirthStatemnet = 'Select Your Birth Date';
  String dateOfBirthStatement = 'Select Your Birth Date';

  Map<String, dynamic> entity = {
    'phoneNumber': null,
    'firstName': null,
    'lastName': null,
    'email': null,
    'gender': null,
    'nationality': null,
    'dateOfBirth': null
  };

  addToEntityFields(data, field) {
    this.entity[field] = data;
    notifyListeners();
  }

//  clearData() {
//    this.entity = {
//      'profileImage': null,
//      'uid': null,
//      'phoneNumber': null,
//      'firstName': null,
//      'lastName': null,
//      'email': null,
//      'gender': null,
//      'nationality': null,
//      'dateOfBirth': null,
//      'isChangeProfileNumber': false,
//      'isSighnedIn': false,
//    };
//    notifyListeners();
//  }

  validateFields() {
    this.validatingStatus = false;
    if (entity['firstName'] != null &&
        entity['firstName'].toString().isNotEmpty &&
        entity['lastName'] != null &&
        entity['lastName'].toString().isNotEmpty &&
        entity['gender'] != null &&
        entity['gender'].toString().isNotEmpty &&
        entity['gender'].toString() != genderfixedValue &&
        entity['nationality'] != null &&
        entity['nationality'].toString().isNotEmpty &&
        entity['nationality'].toString() != nationalityFixedValue &&
        entity['dateOfBirth'] != null &&
        entity['dateOfBirth'].toString().isNotEmpty &&
        entity['dateOfBirth'].toString() != fixedDateOfBirthStatemnet) {
      if (entity['email'] != null &&
          entity['email'].toString().isNotEmpty &&
          RegExp(r'([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$)')
              .hasMatch(entity['email'].toString())) {
        validatingStatus = true;
      } else if (entity['email'].toString() == '' ||
          entity['email'].toString() == null) {
        validatingStatus = true;
      } else {
        validatingStatus = false;
      }
    } else {
      validatingStatus = false;
    }
  }

  void setStatusToLoading(bool status) {
    isLoading = status;
    notifyListeners();
  }

  Future<bool> registerUser(BuildContext context) async {
    try {
      setStatusToLoading(true);
      Map<String, dynamic> userEntity = {
        'registeredDate': DateTime.now(),
        'phoneNumber': entity['phoneNumber'],
        'firstName': entity['firstName'],
        'lastName': entity['lastName'],
        'email': entity['email'],
        'gender': entity['gender'],
        'nationality': entity['nationality'],
        'dateOfBirth': entity['dateOfBirth']
      };
      // send data to Firestore => registering new user
      bool result = await _repository.registerUser(userEntity);
      setStatusToLoading(false);

      notifyListeners();
      return result;
    } catch (e) {
      setStatusToLoading(false);
      return false;
    }
  }

  // methods used to get all posts from repository from firestore
  void getAllUsersListMethod() {
    _repository.getAllUsers().listen((snapshot) {
      snapshot.documents.forEach((data) {
        final _usersModel = UsersModel(
            phoneNumber: data['phoneNumber'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
            gender: data['gender'],
            nationality: data['nationality']);
        usersList.insert(0, _usersModel);
      });
      notifyListeners();
    });
  }
}
