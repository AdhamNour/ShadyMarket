import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shady_market/model/Product.dart';
import 'package:shady_market/screens/ProductScreen.dart';

class ProductWidget extends StatefulWidget {
  //constructor with product ID
  final Product product;
  const ProductWidget({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: InkWell(
          child: Hero(
            child: CachedNetworkImage(
              imageUrl: widget.product.pic,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
            tag: widget.product.id,
          ),
          onTap: () {
            //TODO: show summry
            //FIXME : currently would be showing details
            Navigator.of(context)
                .pushNamed(ProductScreen.routeName, arguments: widget.product);
          },
          onDoubleTap: () {
            //TODO: show a new page with
          },
        ),
        footer: Container(
          color: Colors.black54,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Makise Kurisu",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: null) //TODO implement the shopping cart buttton
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ),
    );
  }
}
