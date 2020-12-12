import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shady_market/model/Product.dart';
import 'package:shady_market/widgets/ProductsWidget.dart';
import 'package:shady_market/widgets/appDrawer.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = "ProductsScreen";
  @override
  Widget build(BuildContext context) {
    List<Product> products = List<Product>.generate(
        20,
        (index) => Product(
            (new Random()).nextInt(10000).toInt(),
            (new Random()).nextInt(10000),
            (new Random()).nextInt(10000).toString(),
            'https://avatarfiles.alphacoders.com/200/200652.jpg',
            (new Random()).nextInt(10000).toString(),
            (new Random()).nextInt(10000).toString(),
            (new Random()).nextDouble(),
            (new Random()).nextDouble(),
            (new Random()).nextInt(10000),
            "Makise Kurisu"));
    return Scaffold(
      drawer: ANAppDrawer(),
      appBar: AppBar(
        title: Text("Available Products"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                TextEditingController controller = TextEditingController();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(controller.text);
                          },
                          icon: Icon(Icons.add_circle),
                          label: Text("search")),
                      FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                          icon: Icon(Icons.cancel),
                          label: Text('cancel'))
                    ],
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('search about:'),
                        TextField(controller: controller)
                      ],
                    ),
                  ),
                ).then((value) {
                  if (value != null) {
                    //TODO: send search request
                  }
                });
              }),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 16 / 11),
        itemBuilder: (context, index) => ProductWidget(
          product: products[index],
        ),
        itemCount: products.length,
      ),
    );
  }
}
