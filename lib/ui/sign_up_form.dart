import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:kuwait_test/globals/validate_add_item.dart';
import 'package:kuwait_test/providers/sign_up_form_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final width;
  final height;

  const SignUpForm({Key key, this.width, this.height}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<FormState> _key = new GlobalKey();
  ValidateAddItem _validateAddItem = ValidateAddItem();
  bool _validate = false;

  String phoneNumber = '';
  String firstName = '';
  String lastName = '';
  String email = '';

  SignUpFormProvider _signUpProvider;

  @override
  void initState() {
    super.initState();
    phoneNumber = '';
    firstName = '';
    lastName = '';
    email = '';
  }

  @override
  Widget build(BuildContext context) {
    _signUpProvider = Provider.of<SignUpFormProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.width / 10)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.white])),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ClipRect(
          child: Form(key: _key, autovalidate: _validate, child: formUI())),
    );
  }

  Widget formUI() {
    double paddingTop = 5.0;
    double paddingBottom = 10.0;
    return Consumer<SignUpFormProvider>(builder: (context, signUp, _) {
      return Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                phoneField(),
                //phone
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                firstNameField(),
                //first
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                lastNameField(),
                //last
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                emailField(),
                //email
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                nationalityField(signUp.entity['nationality']),
                //nationality
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                genderField(signUp.entity['gender']),
                //gender
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                dateOfBirthField(signUp.entity['dateOfBirth']),
                //date of birth

                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                (!signUp.isLoading)
                    ? submitNewValidate(signUp.entity)
                    : LoadingJumpingLine.square(
                        size: widget.width / 5,
                        borderColor: Colors.deepPurple,
                  backgroundColor: Colors.deepPurpleAccent,
                      ),

                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
                Container(
                    margin: EdgeInsets.only(
                        top: paddingTop, bottom: paddingBottom)),
              ],
            ),
          ),
        ],
      );
    });
  }

  /// phone field
  Widget phoneField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: TextFormField(
        initialValue: phoneNumber,
        onSaved: (e) => _signUpProvider.addToEntityFields(e, 'phoneNumber'),
        validator: _validateAddItem.validateMobile,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurpleAccent),
            ),
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
            labelText: 'Phone Number'),
        //style: TextStyle(fontSize: screenWidth/25, color: Colors.black),
      ),
    );
  }

  /// first name field
  Widget firstNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: TextFormField(
        initialValue: firstName,
        onSaved: (e) => _signUpProvider.addToEntityFields(e, 'firstName'),
        validator: _validateAddItem.validateFirstName,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurpleAccent),
            ),
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
            labelText: 'First Name'),
        //style: TextStyle(fontSize: screenWidth/25, color: Colors.black),
      ),
    );
  }

  /// last name field
  Widget lastNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: TextFormField(
        initialValue: lastName,
        onSaved: (e) => _signUpProvider.addToEntityFields(e, 'lastName'),
        validator: _validateAddItem.validateLastName,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurpleAccent),
            ),
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
            labelText: 'Last Name'),
        //style: TextStyle(fontSize: screenWidth/25, color: Colors.black),
      ),
    );
  }

  /// email field
  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: TextFormField(
        initialValue: email,
        onSaved: (e) => _signUpProvider.addToEntityFields(e, 'email'),
        validator: _validateAddItem.validateEmail,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurpleAccent),
            ),
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
            labelText: 'Email'),
        //style: TextStyle(fontSize: screenWidth/25, color: Colors.black),
      ),
    );
  }

  /// gender field
  Widget genderField(gender) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.width / 25),
          border: Border.all(width: 1.0, color: Colors.black45),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.width / 25),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: widget.width / 25),
                child: Container(
                  margin: EdgeInsets.only(top: 1),
                  alignment: Alignment(-1, 1),
                  child: Text('Gender',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25,
                          color: Colors.deepPurpleAccent)),
                ),
              ),
              Container(
                alignment: Alignment(1, 1),
                child: DropdownButton<dynamic>(
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 30,
                      color: Colors.black),
                  value: (gender == null)
                      ? _signUpProvider.genderDefaultValue
                      : gender,
                  onChanged: (newValue) {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }                    _signUpProvider.addToEntityFields(newValue, 'gender');
                    _signUpProvider.genderDefaultValue = newValue;
                  },
                  items: _signUpProvider.genderList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// nationality field
  Widget nationalityField(nationality) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.width / 25),
          border: Border.all(width: 1.0, color: Colors.black45),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.width / 25),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: widget.width / 25),
                child: Container(
                  margin: EdgeInsets.only(top: 1),
                  alignment: Alignment(-1, 1),
                  child: Text('Nationality',
                      style: TextStyle(
                          fontSize: widget.width / 25,
                          color: Colors.deepPurpleAccent)),
                ),
              ),
              Container(
                alignment: Alignment(1, 1),
                child: DropdownButton<dynamic>(
                  style: TextStyle(
                      fontSize: widget.width / 25, color: Colors.black),
                  value: (nationality == null)
                      ? _signUpProvider.nationalityDefaultValue
                      : nationality,
                  onChanged: (newValue) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _signUpProvider.addToEntityFields(newValue, 'nationality');
                    _signUpProvider.nationalityDefaultValue = newValue;
                  },
                  items: _signUpProvider.nationalityList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Date of birth field
  Widget dateOfBirthField(date) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.width / 25),
            border: Border.all(width: 1.0, color: Colors.black45),
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.width / 25),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: widget.width / 25),
                      child: (date != null && date != '')
                          ? Text(
                              date,
                              style: TextStyle(
                                  fontSize: widget.width / 25,
                                  color: Colors.deepPurpleAccent),
                            )
                          : Text(
                              _signUpProvider.dateOfBirthStatement,
                              style: TextStyle(
                                  fontSize: widget.width / 25,
                                  color: Colors.black),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        size: widget.width / 15,
                        color: Colors.deepPurpleAccent,
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }

  /// select date form
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2030));
    if (picked != null && picked != DateTime.now()) {
      _signUpProvider.addToEntityFields(
          picked.toString().split(' ')[0], 'dateOfBirth');
      _signUpProvider.dateOfBirthStatement = picked.toString().split(' ')[0];
    }
  }

  /// Submit Button
  Widget submitNewValidate(entity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: widget.width / 2,
          height: widget.width / 9,
          child: RaisedButton(
              child: Text('Submit'),
              textColor: Colors.white,
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.width / 25),
                  side: BorderSide(width: 1, color: Colors.black12)),
              onPressed: () async {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  await _signUpProvider.validateFields();
                  (_signUpProvider.validatingStatus)
                      ? addUserPost(entity)
                      : showErrorMessage();
                } else {
                  // validation error
                  setState(() {
                    _validate = true;
                  });
                  showErrorMessage();
                }
              }),
        )
      ],
    );
  }

  /// functions to check the connection of internet
  Future checkForInternet() async {
    String connectionState;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionState = 'connected';
      }
    } on SocketException catch (_) {
      connectionState = 'not connected';
    }
    return connectionState;
  }

  /// the main function to add user
  void addUserPost(entity) async {
    checkForInternet().then((futureResp) async {
      if (futureResp.toString() == 'not connected') {
        showErrorConnectionMessage();
      } else {
        bool result = await _signUpProvider.registerUser(context);
        showsDialog(result);
      }
    }).catchError((error) {
      showsDialog(false);
    });
  }

  void showsDialog(bool result){
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: result ? DialogType.SUCCES : DialogType.ERROR,
      dismissOnTouchOutside: false,
      headerAnimationLoop: true,
      body: Center(
        child: Text(
          result
              ? 'Success Uploading'
              : 'Error Happened during uploading! Please Try again',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      btnOkOnPress: () {
        if(result) {
          Navigator.pop(context);
        }
      },
    )..show();
  }

  /// Error message
  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text('Please add all the required fields...'),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  /// Error connection message
  void showErrorConnectionMessage() {
    final snackbar = SnackBar(
        backgroundColor: Colors.red[300],
        content: Text(
          'Internet connection error...',
          style: TextStyle(color: Colors.white, fontSize: widget.width / 25),
        ),
        duration: new Duration(seconds: 3));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
