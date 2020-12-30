import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shady_market/models/Person.dart';

Future<Person> getUserData({int id, int token: 0}) async {
// Sending a POST request
  const url = 'http://192.168.1.7:4000/users/show/';
  var headers = {"token": token.toString(), "sellerID": id.toString()};

// Sending a POST request with headers
  http.Response response = await http.get(url, headers: headers);

  var result = jsonDecode(response.body);
}
