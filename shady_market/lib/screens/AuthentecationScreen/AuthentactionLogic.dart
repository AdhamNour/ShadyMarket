import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:http/http.dart' as http;
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/utils.dart';

class AuthentcationLogicUtils {
  static void SignIn(
      {@required BuildContext ctx,
      @required String email,
      @required String password}) async {
      // Sending a POST request
    const url = 'http://192.168.1.7:4000/sign_in';
    const headers = {'Content-Type': 'application/json'};

    var body = <String, dynamic>{"email": email, "password": password};
    // Sending a POST request with headers
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    var result = jsonDecode(response.body);
    print(result);
    if (result['success']) {
      // add id to the person
      Provider.of<CurrentUserProvider>(ctx, listen: false).currentUser =
          await getUserData(id: result['token']);
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
      @required String full_name,
      @required BuildContext ctx,}) async {
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
      //TODO: SIGN UP sucsseful
      showDialog(context:ctx, child:AlertDialog(
        title: Text("Sign Up success"),
        content: Text("You can sign in with your account now"),
      ));
    }
  }
}
