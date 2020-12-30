import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/widget/ProductWidget.dart';
import 'package:shady_market/widget/appDrawer.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProdcutsListProvider>(context).prodcuts;

    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 6 / 10),
        itemBuilder: (context, index) => Provider(
          child: ProductWidget(),
          create: (context) => products[index],
        ),
        itemCount: products.length,
      ),
      appBar: AppBar(
        title: Text("Products Screen"),
      ),
      drawer: AppDrawer(),
    );
  }
}
