import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video/Authentictions/databases.dart';
import 'package:video/design.dart';

import 'package:video/pages/camera1.dart';
import 'package:video/pages/upload.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;
  bool isLoading = false;
  var _authmethods = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditing = new TextEditingController();
  TextEditingController passwordTextEditing = new TextEditingController();

  signIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      // ignore: deprecated_member_use
      _authmethods
          .signInWithEmailAndPassword(
              email: emailTextEditing.text, password: passwordTextEditing.text)
          .then((value) async {
        print(value);
        if (value != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Upload()));
        } else {
          print("not opened");
          print(value);
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Record'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 50,
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Container(
                              //color: Colors.yellow,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  TextFormField(
                                    controller: emailTextEditing,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    validator: (value) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)
                                          ? null
                                          : ' Please provide valid Email';
                                    },
                                    decoration: textFieldDecoration(
                                        'Enter Email', 'Email'),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    decoration: textFieldDecoration(
                                        'Enter Password', 'password'),
                                    controller: passwordTextEditing,
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    obscureText: true,
                                    validator: (value) {
                                      return value.length > 6
                                          ? null
                                          : 'please enter min 6 char password';
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    // padding: EdgeInsets.symmetric(vertical: 10),
                                    child: RaisedButton(
                                      child: Text('Sign In'),
                                      onPressed: () async {
                                        CircularProgressIndicator();
                                        signIn();

                                        print("loged in seccesfully");
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      color: Colors.blueGrey,
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
    );
  }
}
