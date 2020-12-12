import 'package:flutter/material.dart';

import '../API.dart';
import '../DATA.dart';
import '../model/Person.dart';
import 'ProductsScreen.dart';

class Login extends StatefulWidget {
  static const routeName = '/';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  Future<void> _showSucess() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Success'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFailure() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failure!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Failed'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shady Market Place"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              //Welcome
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
              child: Text(
                "Welcome in Shady Market Place!",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline),
              ),
            ),
            Container(
              //User Name Text Field
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                cursorColor: Colors.red,
                controller: userName,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    labelText: "User Name",
                    labelStyle: TextStyle(color: Colors.red)),
              ),
            ),
            Container(
              //Password Text Field
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: userPassword,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.red),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                //color: Colors.blue,
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: () async {
                          /**
                           * Send the username and password => signIn
                           */
                          dynamic data =
                              await loginUser(userName.text, userPassword.text);
                          if (data["message"].contains("success")) {
                            currentUser = Person(
                                id: data['data']['ID'],
                                email: data['data']['email'],
                                credit: data['data']['Credit'],
                                location: data['data']['location'],
                                name: data['data']['Name'],
                                pic: data['data']['pic']);
                            Navigator.pushNamed(
                                context, ProductsScreen.routeName);
                          }
                        },
                        color: Colors.red,
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: () async {
                          /**
                           * Send the username and password => signIn
                           * if sucessfull route to Product Screen
                           */
                          dynamic data = await registerUser(
                              userName.text, userPassword.text);
                          if (data["message"].contains("success")) {
                            _showSucess();
                          } else {
                            _showFailure();
                          }
                        },
                        color: Colors.red,
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ProductsScreen.routeName);
                        },
                        color: Colors.red,
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Text(
                          "home screen",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
