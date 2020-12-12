import "package:flutter/material.dart";
import "package:shady_market/model/SoldTransaction.dart";
import "package:shady_market/model/BoughtTransaction.dart";
import 'package:shady_market/API.dart';
import 'package:shady_market/widgets/waiting.dart';

import '../API.dart';
import '../API.dart';
import '../API.dart';
import '../API.dart';
import '../model/SoldTransaction.dart';

class TransactionsScreen extends StatelessWidget {
  static const routeName = '/TransactionsScreen';
  TransactionsScreen({Key key}) : super(key: key);

  List<SoldTransaction> T = List();
  List<BoughtTransaction> S = List();
  Future Trans() async {
    var responce = await getTransactions();
    if (responce['success']) {
      responce['Sold'].forEach((element) {
        T.add(SoldTransaction(
            buyer: element['Buyer'],
            id: element['Timestamp'],
            product: element['Product']));
      });
      responce['Bought'].forEach((element) {
        S.add(BoughtTransaction(
            seller: element['Seller'],
            id: element['Timestamp'],
            product: element['Product']));
      });
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Trans(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [
                  Text("Sold Transactions"),
                  ListView.builder(
                    itemCount: T.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "ID: ${T[index].id}     ,Product Name: ${T[index].product}     ,Buyer: ${T[index].buyer}"),
                      );
                    },
                  ),
                  Text("Bought Transactions"),
                  ListView.builder(
                    itemCount: S.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "ID: ${S[index].id}     ,Product Name: ${S[index].product}     ,Seller: ${S[index].seller}"),
                      );
                    },
                  ),
                ]);
              }
              return Waiting();
            }));
  }
}
