import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/widget/waiting.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionsPage extends StatelessWidget {
  static const routeName = '/transactions';

  Future prepareTransactions(BuildContext ctx) async {
    const url = 'http://192.168.1.7:4000/transactions';
    const headers = {'Content-Type': 'application/json'};

    var body = <String, dynamic>{
      "token":
          Provider.of<CurrentUserProvider>(ctx, listen: false).currentUser.id
    };
// Sending a POST request with headers
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);

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
              List<Widget> transactions = snapshot.data
                  .map((element) => Card(
                        child: Text("Hiiiiiiii"),
                        shadowColor: Colors.grey,
                      ))
                  .toList();
              return ListView(
                children: transactions,
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Column(
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
              );
            } else {
              return Waiting();
            }
          },
        )),
      ),
    );
  }
}
