import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/widget/waiting.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//FIXME: reimplement this

class TransactionsPage extends StatelessWidget {
  static const routeName = '/transactions';

  Future prepareTransactions(BuildContext ctx) async {
    var id =
        Provider.of<CurrentUserProvider>(ctx, listen: false).currentUser.id;
    const url = 'http://192.168.1.7:4000/transactions';
    var headers = {"token": id.toString()};

// Sending a POST request with headers
    http.Response response = await http.get(url, headers: headers);

    var result = jsonDecode(response.body);
    if (result['success']) {
      //print('auth success');
      // add id to the person
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
            child: FutureBuilder(
          future: prepareTransactions(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length == 0) {
                return Opacity(
                  opacity: 0.5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/empty.png",
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("Not Transactions So Far"),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                List<Widget> transactions = [];
                snapshot.data['products']
                    .forEach((value) => transactions.add(Card(
                          child: Text(
                              "Product id: ${value['product']}\nBuyer id: ${value['buyer']}"),
                          shadowColor: Colors.grey,
                        )));
                return ListView(
                  children: transactions,
                );
              }
            } else {
              return Waiting();
            }
          },
        )),
      ),
    );
  }
}
