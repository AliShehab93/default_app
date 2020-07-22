import 'package:flutter/material.dart';
import 'package:kuwait_test/ui/sign_up_form.dart';

class SignUp extends StatelessWidget {

  final width;
  final height;

  const SignUp({Key key, this.width, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment(0.0, 0.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent, Colors.white10 ])
          ),
          child: SignUpForm(width: width, height:  height),
        ));
  }
}
