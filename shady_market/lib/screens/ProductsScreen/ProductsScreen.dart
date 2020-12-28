import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 6 / 10),
        itemBuilder: (context, index) => Text(index.toString()),
        itemCount: 100,
      ),
    );
  }
}
