import 'package:flutter/material.dart';
import 'package:kuwait_test/ui/main_page.dart';
import 'package:kuwait_test/ui/sign_up.dart';
import 'package:provider/provider.dart';
import 'providers/sign_up_form_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpFormProvider()),
      ],
      child: // Smart Refresher under the global configuration subtree, here are a few particularly important attributes
          MaterialApp(
        home: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Sign Up'),
              backgroundColor: Colors.deepPurple,
            ),
            body: MainPage(
                width: constraints.maxWidth, height: constraints.maxHeight),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              hoverColor: Colors.yellow,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUp(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight)),
                );
              },
              tooltip: 'Add User',
              child: Icon(Icons.person_add, size: constraints.maxWidth / 10,),
            ),
          );
        }),
      ),
    );
  }
}
