import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/screens/ProductDetailsScreen/ProductDetailsScreen.dart';
import 'package:shady_market/widget/ProfilePageWidgets/CreditField.dart';
import 'package:shady_market/widget/ProfilePageWidgets/ImageField.dart';
import 'package:shady_market/widget/ProfilePageWidgets/TextField.dart';
import 'package:shady_market/utils.dart';

Product target;

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
      } else {
        target = Product(
            owner_id: Provider.of<CurrentUserProvider>(context, listen: false)
                .currentUser
                .id,
            pictureUrl:
                'https://initiate.alphacoders.com/download/wallpaper/crop-or-stretch/769160/cropped-400-400-769160.jpg/1650283600708680');
      }
      setState(() {});
    });
    super.initState();
  }

  void _editData(Product product) {
    setState(() {
      if (_edit) {
        Product newProduct = product.copyWith(
            name: _nameTextEditingController.text,
            description: _emailTextEditingController.text,
            category: _categoryTextEditingController.text,
            tags: _tagsTextEditingController.text
            //TODO: Add URL Edit
            );
        updateProduct(newProduct);
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
                        getRadianFromDegree(255), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.save),
                            Colors.green,
                            onClick: () => _editData(target),
                          ),
                        )),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(
                        getRadianFromDegree(190), 100 * degOneTranslate.value),
                    child: Transform.rotate(
                        angle: rotationAnimation.value,
                        child: Builder(
                          builder: (context) => CircularButton(
                            50,
                            Icon(Icons.cancel),
                            Colors.red,
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

class ProductEditScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Profile Image (Image in a field)
            ProfilePicture(
              URL: target.pictureUrl== null?"": target.pictureUrl,
              isEditing: _edit,
            ),
            //Name (Text Field)
            ProfileInfo(
              edit: _edit,
              info: target.name== null ? "Not Known yet" : target.name,
              title: "Name",
              controller: _nameTextEditingController,
            ),
            //Email (Text Field)
            ProfileInfo(
              edit: _edit,
              info: target.description== null ? "Not Known yet" : target.description,
              title: "Description",
              controller: _emailTextEditingController,
            ),
            //Credit (Text Field)
            CreditField(
              info: target.price== null? '0' :target.price.toString(),
              title: 'price',
              isEdit: _edit,
              savingFunction: (newValue) {
                target = target.copyWith(price: double.parse(newValue));
              },
            ),
            CreditField(
                info: target.quantity== null?'0':target.quantity.toString(),
                title: 'quantity',
                isEdit: _edit,
                savingFunction: (newValue) {
                  target = target.copyWith(quantity: int.parse(newValue));
                }),
            //Location (Text Field)
            ProfileInfo(
              edit: _edit,
              info: target.category == null ? "Not Known yet" : target.category,
              title: "category",
              controller: _categoryTextEditingController,
            ),
            ProfileInfo(
              edit: _edit,
              info: target.tags == null ? "Not Known yet" : target.tags,
              title: "tags",
              controller:
                  _tagsTextEditingController, 
            ),
          ],
        ),
      ),
    );
  }
}
