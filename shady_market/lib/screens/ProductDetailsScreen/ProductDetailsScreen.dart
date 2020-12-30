import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shady_market/models/Product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = "/ProductDetailsScreen";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;
    final imageRatio = 0.25;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: imageRatio * size.height,
            child: Card(
              elevation: 4,
              child: Hero(
                tag: product.id,
                child: CachedNetworkImage(
                  imageUrl: product.pictureUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
              margin: EdgeInsets.all(5),
            ),
          )
        ],
      ),
    );
  }
}
