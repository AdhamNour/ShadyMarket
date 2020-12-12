import 'dart:convert';

import "package:http/http.dart" as http;

import 'DATA.dart';
import 'DATA.dart';
import 'DATA.dart';
import 'DATA.dart';
import 'DATA.dart';
import 'DATA.dart';
import 'DATA.dart';
import 'DATA.dart';

class Album {
  final userName;
  final password;

  Album({this.userName, this.password});
}

Future<dynamic> registerUser(String userName, String password) async {
  final http.Response response = await http.post(
    'http://192.168.1.7:4000/sign_up',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': userName, 'password': password}),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> loginUser(String userName, String password) async {
  final http.Response response = await http.post(
    'http://192.168.1.7:4000/sign_in',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': userName, 'password': password}),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> getProfile(String id) async {
  final http.Response response = await http.get(
    'http://192.168.1.7:4000/userinfo/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'id': id
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> updateProfile(
    {String Name, String Pic, String Location}) async {
  final http.Response response = await http.put(
    'http://192.168.1.7:4000/Edit/Profile',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'ID': currentUser.id,
      'token': currentUser.id,
      'Image': Pic,
      'Location': Location
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> updateCredit(double credit) async {
  final http.Response response = await http.put(
    'http://192.168.1.7:4000/usercredit/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{'credit': credit, 'token': currentUser.id}),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> getProducts() async {
  final http.Response response = await http.get(
    'http://192.168.1.7:4000/products',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> addProduct({
  String name,
  String description,
  int quantity,
  String pic,
  double price,
}) async {
  final http.Response response = await http.post(
    'http://192.168.1.7:4000/updateproduct',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'token': currentUser.id,
      'ownerID': currentUser.id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'pic': pic,
      'price': price
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> deleteProduct(String id) async {
  final http.Response response = await http.get(
    'http://192.168.1.7:4000/deleteproduct',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'id': id,
      'token': currentUser.id
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> updateProduct(
    {String name,
    String description,
    String quantity,
    String pic,
    String price,
    String id}) async {
  final http.Response response = await http.put(
    'http://192.168.1.7:4000/updateproduct',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'pic': pic,
      'price': price,
      'id': id,
      'token': currentUser.id
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> searchProduct({String name}) async {
  final http.Response response = await http.post(
    'http://192.168.1.7:4000/updateproduct',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> buyProduct({String product, int quantity}) async {
  final http.Response response = await http.post(
    'http://192.168.1.7:4000/products/purchase',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id': product,
      'buyerID': currentUser.id,
      'quantity': quantity,
      'token': currentUser.id
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dynamic> getTransactions() async {
  final http.Response response = await http.post(
    'http://192.168.1.7:4000/get/transactions',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'ID': currentUser.id,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
