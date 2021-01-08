import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/screens/ProductDetailsScreen/ProductDetailsScreen.dart';
import 'package:shady_market/widget/ProfilePageWidgets/CreditField.dart';
import 'package:shady_market/widget/ProfilePageWidgets/ImageField.dart';
import 'package:shady_market/widget/ProfilePageWidgets/TextField.dart';
import 'package:shady_market/utils.dart';

Product target;
bool isNewProduct;

class ProductEdit extends StatefulWidget {
  static const String routeName = '/ProductEdit';
  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit>
    with SingleTickerProviderStateMixin {
  @override
  bool _edit = true;
  TextEditingController _nameTextEditingController,
      _emailTextEditingController,
      _categoryTextEditingController,
      _tagsTextEditingController;

  AnimationController animationController;
  Animation degOneTranslate, rotationAnimation;
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
    super.initState();
    _nameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _categoryTextEditingController = TextEditingController();
    _tagsTextEditingController = TextEditingController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    degOneTranslate = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut));
    rotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    animationController.addListener(translationalMoving);
    Future.delayed(Duration.zero).then((v) {
      target = ModalRoute.of(context).settings.arguments as Product;
      if (target != null) {
        getUserData(id: target.owner_id).then((v) {
          setState(() {
            productOwner = v;
          });
        });
        isNewProduct = false;
      } else {
        target = Product(
            owner_id: Provider.of<CurrentUserProvider>(context, listen: false)
                .currentUser
                .id,
            pictureUrl:
                'https://initiate.alphacoders.com/download/wallpaper/crop-or-stretch/769160/cropped-400-400-769160.jpg/1650283600708680');
        isNewProduct = true;
      }
      setState(() {});
    });
    super.initState();
  }

  void _editData(Product product, BuildContext ctx) {
    setState(() {
      if (_edit) {
        Product newProduct = product.copyWith(
            name: _nameTextEditingController.text,
            description: _emailTextEditingController.text,
            category: _categoryTextEditingController.text,
            tags: _tagsTextEditingController.text
            //TODO: Add URL Edit
            );
        if (newProduct.quantity == null) {
          showDialog(
              context: ctx,
              child: AlertDialog(
                title: Text("There's some error occured while editing"),
                content: Text("The Quantity of your product is not modified"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("OK"))
                ],
              ));
              return;
        }
        else if (newProduct.price == null) {
          showDialog(
              context: ctx,
              child: AlertDialog(
                title: Text("There's some error occured while editing"),
                content: Text("The Price of your product is not modified"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("OK"))
                ],
              ));
              return;
        }
        var x = Provider.of<ProdcutsListProvider>(ctx, listen: false);
        if (isNewProduct) {
          x.addProduct(newProduct);
        } else {
          x.updateProduct(newProduct);
        }
      }
      Navigator.of(context).pop();

      print(_edit);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _categoryTextEditingController.dispose();
    _tagsTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            ProductEditScreen(
              edit: _edit,
              nameTextEditingController: _nameTextEditingController,
              emailTextEditingController: _emailTextEditingController,
              locationTextEditingController: _categoryTextEditingController,
              tagsTextEditingController: _tagsTextEditingController,
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
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(270), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.delete),
                            Colors.red,
                            onClick: () {
                              //TODO: delete item
                              //Add are you sure things
                              Provider.of<ProdcutsListProvider>(context,
                                      listen: false)
                                  .deleteProduct(target);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (route) => false);
                            },
                          ),
                        )),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(225), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.save),
                            Colors.green,
                            onClick: () => _editData(target, context),
                          ),
                        )),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(180), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.cancel),
                            Colors.deepOrange,
                            onClick: () {
                              Navigator.of(context).pop();
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
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProductEditScreen extends StatefulWidget {
  ProductEditScreen({
    Key key,
    @required bool edit,
    @required TextEditingController nameTextEditingController,
    @required TextEditingController emailTextEditingController,
    @required TextEditingController locationTextEditingController,
    @required TextEditingController tagsTextEditingController,
  })  : _edit = edit,
        _nameTextEditingController = nameTextEditingController,
        _emailTextEditingController = emailTextEditingController,
        _categoryTextEditingController = locationTextEditingController,
        _tagsTextEditingController = tagsTextEditingController,
        super(key: key);

  final bool _edit;
  final TextEditingController _nameTextEditingController;
  final TextEditingController _emailTextEditingController;
  final TextEditingController _categoryTextEditingController;
  final TextEditingController _tagsTextEditingController;

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Profile Image (Image in a field)
            ProfilePicture(
              URL: target == null ? "":(target.pictureUrl == null ? "" : target.pictureUrl),
              isEditing: widget._edit,
              onSave:(newValue) {
                setState(() {
                  target= target.copyWith(pictureUrl: newValue);
                });
              } ,
            ),
            //Name (Text Field)
            ProfileInfo(
              edit: widget._edit,
              info: target.name == null ? "Not Known yet" : target.name,
              title: "Name",
              controller: widget._nameTextEditingController,
            ),
            //Email (Text Field)
            ProfileInfo(
              edit: widget._edit,
              info: target.description == null
                  ? "Not Known yet"
                  : target.description,
              title: "Description",
              controller: widget._emailTextEditingController,
            ),
            //Credit (Text Field)
            CreditField(
              info: target.price == null ? '0' : target.price.toString(),
              title: 'price',
              isEdit: widget._edit,
              savingFunction: (newValue) {
                target = target.copyWith(price: double.parse(newValue));
              },
            ),
            CreditField(
                info:
                    target.quantity == null ? '0' : target.quantity.toString(),
                title: 'quantity',
                isEdit: widget._edit,
                savingFunction: (newValue) {
                  target = target.copyWith(quantity: int.parse(newValue));
                }),
            //Location (Text Field)
            ProfileInfo(
              edit: widget._edit,
              info: target.category == null ? "Not Known yet" : target.category,
              title: "category",
              controller: widget._categoryTextEditingController,
            ),
            ProfileInfo(
              edit: widget._edit,
              info: target.tags == null ? "Not Known yet" : target.tags,
              title: "tags",
              controller: widget._tagsTextEditingController,
            ),
          ],
        ),
      ),
    );
  }
}
