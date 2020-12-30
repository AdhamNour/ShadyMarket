import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/screens/ProductDetailsScreen/ProductDetailsScreen.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: InkWell(
          child: Hero(
            tag: product.id,
            child: CachedNetworkImage(
              imageUrl: product.pictureUrl,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error),
              ),
              fit: BoxFit.fill,
            ),
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product),
        ),
        footer: Container(
          color: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    product.name,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () => print('buy function to be implemented'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
