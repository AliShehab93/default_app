import 'package:flutter/material.dart';
import 'package:kuwait_test/providers/sign_up_form_bloc.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final width;
  final height;

  const MainPage({Key key, this.width, this.height}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<SignUpFormProvider>(context, listen: false)
            .getAllUsersListMethod());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Colors.deepPurple, Colors.deepPurpleAccent, Colors.white ])
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ClipRect(
          child: Consumer<SignUpFormProvider>(builder: (context, signUp, _) {
            return signUp.usersList.isNotEmpty ? ListView.builder(
              itemCount: signUp.usersList.length,
              itemBuilder: (context, position) {
                return Card(
                  margin: EdgeInsets.all(widget.width / 30),
                  child: Padding(
                    padding: EdgeInsets.all(widget.width/20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Email: ${signUp.usersList[position].email}',
                                style: TextStyle(fontSize: widget.width / 25)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Name: ${signUp.usersList[position].firstName} ${signUp.usersList[position].lastName}',
                                style: TextStyle(fontSize: widget.width / 25)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ) : Container();
          })),
    );
  }
}
