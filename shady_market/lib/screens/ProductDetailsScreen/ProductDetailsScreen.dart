import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/screens/ProductEdit/ProductEdit.dart';
import 'package:shady_market/screens/ProfileScreen/ProfileScreen.dart';
import 'package:shady_market/utils.dart';
import 'package:shady_market/widget/SABT.dart';
import 'package:shady_market/widget/SellerWidget.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/ProductDetailsScreen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslate, rotationAnimation;
  Product _product;
  Person productOwner;

  void translationalMoving() {
    setState(() {});
  }

  double getRadianFromDegree(double degree) {
    double unitRadial = 180 / pi;
    return degree / unitRadial;
  }

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
    Future.delayed(Duration.zero).then((v) {
      _product = ModalRoute.of(context).settings.arguments as Product;
      getUserData(id: _product.owner_id).then((v) {
        setState(() {
          productOwner = v;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUserProvider>(context).currentUser;
    final isOwner =
        _product != null ? (_product.owner_id == currentUser.id) : false;
    print(currentUser.name);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          ProductDataisScreenContent(
            size: size,
            product: _product,
            productOwner: productOwner,
          ),
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
                if (currentUser.name != null)
                  if (!isOwner)
                    Transform.translate(
                      offset: Offset.fromDirection(getRadianFromDegree(270),
                          100 * degOneTranslate.value),
                      child: Transform.rotate(
                          angle: rotationAnimation.value,
                          child: Builder(
                            builder: (context) => CircularButton(
                              50,
                              Icon(Icons.shopping_cart),
                              Colors.deepOrange,
                              onClick: () {
                                purchaseProduct(_product, context);
                              },
                            ),
                          )),
                    ),
                if (!isOwner)
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(225), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.account_circle),
                            Colors.deepPurple,
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                  ProfilePage.routeName,
                                  arguments: productOwner);
                            },
                          ),
                        )),
                  ),
                  if (isOwner)
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(180), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.edit),
                            Colors.green,
                            onClick: () {
                              Navigator.of(context).pushNamed(
                                  ProductEdit.routeName,
                                  arguments: _product);
                            },
                          ),
                        )),
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
    @required this.productOwner,
  });

  final Size size;
  final Product product;
  final Person productOwner;

  @override
  _ProductDataisScreenContentState createState() =>
      _ProductDataisScreenContentState();
}

class _ProductDataisScreenContentState
    extends State<ProductDataisScreenContent> {
  //Person productOwner;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.product != null
          ? CustomScrollView(
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
                          imageUrl: widget.product.pictureUrl,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error)),
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
                        Expanded(
                            child: widget.productOwner != null
                                ? SellerWidget(
                                    widget.productOwner,
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(ProfilePage.routeName,
                                            arguments: widget.productOwner),
                                  )
                                : Container())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.product.description),
                  ),
                ])),
              ],
            )
          : Container(),
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
