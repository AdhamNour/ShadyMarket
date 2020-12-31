import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:shady_market/models/Person.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';

Future<Person> getUserData({int id, int token: 0}) async {
// Sending a POST request
  const url = 'http://192.168.1.7:4000/users/show/';
  var headers = {"token": token.toString(), "sellerID": id.toString()};

// Sending a POST request with headers
  http.Response response = await http.get(url, headers: headers);

  var result = jsonDecode(response.body);
  Map<String, dynamic> userData = result['users'][0];
  print(userData);
  return Person.fromMap(userData);
}

void purchaseProduct(Product product, BuildContext ctx) {
  //show dialog box to get the quantity
  int counter = 1;
  showDialog(
      context: ctx,
      useSafeArea: true,
      child: StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Choose the quantity"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("choose the quantity for ${product.name}"),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FlatButton(
                      onPressed: () =>
                          setState(() => counter = max(counter - 1, 1)),
                      child: Icon(Icons.remove)),
                  Container(
                    child: Text(counter.toString()),
                  ),
                  FlatButton(
                      onPressed: () => setState(() => counter++),
                      child: Icon(Icons.add)),
                ])
              ],
            ),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Discard',
                    style: TextStyle(color: Colors.red),
                  )),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(counter),
                  child: Text('Purchase')),
            ],
          );
        },
      )).then((value) {
    if (value != null) {
      requestPurchases(product.id, ctx, value);
    }
  });
}

void requestPurchases(int product, BuildContext ctx, int quantity) async {
  //send the http request to the server
  print("Hello world! from requestPurchases");
  final currentUser =
      Provider.of<CurrentUserProvider>(ctx, listen: false).currentUser;
  // Sending a POST request
  const url = 'http://192.168.1.7:4000/products/purchase/';
  var headers = {"Content-type": "application/json"};
  var body = {
    "token": currentUser.id.toString(),
    "id": product,
    "quantity": quantity.toString()
  };
// Sending a POST request with headers
  http.Response response =
      await http.post(url, headers: headers, body: jsonEncode(body));

  var result = jsonDecode(response.body);
  print(result);
}
