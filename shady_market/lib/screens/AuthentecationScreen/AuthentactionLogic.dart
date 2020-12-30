import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:http/http.dart' as http;

class AuthentcationLogicUtils {
  static void SignIn(
      {@required BuildContext ctx,
      @required String email,
      @required String password}) async {
    print("Singing In For $email with password $password");

// Sending a POST request
    const url = 'http://192.168.1.7:4000/sign_in';
    const headers = {'Content-Type': 'application/json'};

    var body = <String, dynamic>{"email": email, "password": password};
// Sending a POST request with headers
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    var result = jsonDecode(response.body);
    if (result['success']) {
      //print('auth success');
      // add id to the person
      print(result);

      Provider.of<CurrentUserProvider>(ctx, listen: false).currentUser = Person(
          email: email, password: password, id: int.parse(result['token']));
    } else {
      showDialog(
          context: ctx,
          child: AlertDialog(
            title: Text("Log in Failed"),
            content: Text("Log in Failed due to internal error"),
          ));
    }
  }

  static void SignUP(
      {@required String email,
      @required String password,
      @required String full_name}) async {
    // Sending a POST request
    const url = 'http://192.168.1.7:4000/sign_up';
    const headers = {'Content-Type': 'application/json'};

    var body = <String, dynamic>{
      "email": email,
      "password": password,
      "name": full_name
    };
// Sending a POST request with headers
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    var result = jsonDecode(response.body);
    if (result['success']) {
      print('auth success');
      print(
          "Singing Up For $email with password $password and name is $full_name");
    }
  }
}
