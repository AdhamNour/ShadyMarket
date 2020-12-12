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
            'https://initiate.alphacoders.com/download/wallpaper/crop-or-stretch/769160/cropped-300-300-769160.jpg/695763090829240',
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
              onPressed: null), //TODO: add searching function here
          IconButton(
              icon: Icon(Icons.filter),
              onPressed: null) //TODO  add fillter functionality here
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
