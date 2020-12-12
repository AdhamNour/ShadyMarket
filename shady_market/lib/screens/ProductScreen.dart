import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shady_market/model/Product.dart';
import 'package:shady_market/screens/EditProductScreen.dart';
import 'package:shady_market/widgets/SABT.dart';
/**
 * this screen has the following job
 * 1. showing product 
 * 2. editing product
 * 3.uploading product
 */

class ProductScreen extends StatefulWidget {
  static const routeName = '/ProductScreen';

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslate, rotationAnimation;

  void translationalMoving() {
    setState(() {});
  }

  double getRadianFromDegree(double degree) {
    double unitRadial = 180 / pi;
    return degree / unitRadial;
  }

  final isOwner = (new Random()).nextBool(); //FIXME

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    degOneTranslate = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut));
    rotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    super.initState();
    animationController.addListener(translationalMoving);
  }

  @override
  Widget build(BuildContext context) {
    final Product _product =
        ModalRoute.of(context).settings.arguments as Product;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          ProductDataisScreenContent(size: size, product: _product),
          Positioned(
            bottom: 20,
            right: 20,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                IgnorePointer(
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                  ),
                ),
                if (!isOwner)
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(270), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.shopping_cart),
                            Colors.deepOrange,
                            onClick: () {
                              //addToCart(context, _product);
                              //TODO add to cart to be implemented
                              print(isOwner);
                            },
                          ),
                        )),
                  ),
                if (isOwner)
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(180), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                      angle: (2 * pi) - rotationAnimation.value,
                      child: CircularButton(
                        50,
                        null,
                        Colors.cyanAccent,
                        doneWidget: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.edit),
                            Colors.deepPurple,
                            onClick: () {
                              //chatWithOwner(context, _product.owner_Id);

                              print(isOwner);
                              Navigator.of(context).pushNamed(
                                  EditProductScreen.routeName,
                                  arguments: _product);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                CircularButton(50, Icon(Icons.add), Colors.blue[900],
                    onClick: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
      height: size.height,
      width: size.width,
    ));
  }
}

class ProductDataisScreenContent extends StatefulWidget {
  ProductDataisScreenContent({
    @required this.size,
    @required this.product,
  });

  final Size size;
  final Product product;

  @override
  _ProductDataisScreenContentState createState() =>
      _ProductDataisScreenContentState();
}

class _ProductDataisScreenContentState
    extends State<ProductDataisScreenContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 4 * widget.size.height / 5,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SABT(child: Text(widget.product.name)),
              ),
              background: Hero(
                tag: widget.product.id,
                child: CachedNetworkImage(
                    imageUrl: widget.product.pic,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error)),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Owner: '),
                  //Expanded(child: SellerWidget(widget.product.ownerID,onTap: ()=>chatWithOwner(context,widget.product.ownerID),))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.discription),
            ),
          ])),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double r;
  final Color color;
  final Icon icon;
  final Function onClick;
  final Widget doneWidget;
  CircularButton(this.r, this.icon, this.color,
      {this.onClick, this.doneWidget});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      height: r,
      width: r,
      child: onClick == null
          ? doneWidget
          : IconButton(
              icon: icon,
              onPressed: onClick,
              enableFeedback: true,
            ),
    );
  }
}
