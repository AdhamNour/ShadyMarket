import "package:flutter/material.dart";
import "package:shady_market/model/SoldTransaction.dart";
import "package:shady_market/model/BoughtTransaction.dart";

class TransactionsScreen extends StatelessWidget {
  static const routeName = '/TransactionsScreen';
  const TransactionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SoldTransaction> T =
        ModalRoute.of(context).settings.arguments as List<SoldTransaction>;
    List<BoughtTransaction> S =
        ModalRoute.of(context).settings.arguments as List<BoughtTransaction>;

    return Scaffold(
        body: Column(children: [
      Text("Sold Transactions"),
      ListView.builder(
        itemCount: T.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                "ID: ${T[index].id}     ,Product Name: ${T[index].product}     ,Buyer: ${T[index].buyer}     ,Quantity: ${T[index].quantity}"),
          );
        },
      ),
      Text("Bought Transactions"),
      ListView.builder(
        itemCount: S.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                "ID: ${S[index].id}     ,Product Name: ${S[index].product}     ,Seller: ${S[index].seller}     ,Quantity: ${S[index].quantity}"),
          );
        },
      ),
    ]));
  }
}
