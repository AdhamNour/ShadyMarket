import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/screens/ProductDetailsScreen/ProductDetailsScreen.dart';
import 'package:shady_market/screens/ProductsScreen/ProductsScreen.dart';
import 'package:shady_market/screens/ProfileScreen/ProfileScreen.dart';
import 'package:shady_market/screens/TransactionsList/TransactionList.dart';
import 'package:shady_market/widget/ProfilePageWidgets/CreditField.dart';
import 'package:shady_market/widget/ProfilePageWidgets/GradientButton.dart';
import 'package:shady_market/widget/ProfilePageWidgets/ImageField.dart';
import 'package:shady_market/widget/ProfilePageWidgets/TextField.dart';
import 'package:shady_market/utils.dart';

class ProductEdit extends StatefulWidget {
  @override
  _ProductEditState createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit>
    with SingleTickerProviderStateMixin {
  @override
  bool _edit = true;
  TextEditingController _nameTextEditingController,
      _emailTextEditingController,
      _locationTextEditingController;

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
    super.initState();
    _nameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _locationTextEditingController = TextEditingController();
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

  void _editData() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_edit) {
        final x = Provider.of<CurrentUserProvider>(context, listen: false)
            .currentUser
            .copyWith(
                name: _nameTextEditingController.text,
                email: _emailTextEditingController.text,
                location: _locationTextEditingController.text);
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser =
            x;
        Provider.of<CurrentUserProvider>(context, listen: false)
            .updateCurrentUserData();
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
    _locationTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final Person user = ModalRoute.of(context).settings.arguments as Person;
    final isOwner = true;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_left,
              size: 50,
            ),
            onPressed: null),
      ),
      body: Container(
        child: Stack(
          children: [
            ProductEditScreen(
                user: user,
                edit: _edit,
                nameTextEditingController: _nameTextEditingController,
                emailTextEditingController: _emailTextEditingController,
                locationTextEditingController: _locationTextEditingController),
            if (!isOwner)
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
                                //TODO: purchaseProduct
                                purchaseProduct(_product, context);
                              },
                            ),
                          )),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadianFromDegree(225),
                          100 * degOneTranslate.value),
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
                    // Transform.translate(
                    //   offset: Offset.fromDirection(
                    //       getRadianFromDegree(180), 100 * degOneTranslate.value),
                    //   child: Transform.rotate(
                    //     angle: (2 * pi) - rotationAnimation.value,
                    //     child: CircularButton(
                    //       50,
                    //       null,
                    //       Colors.cyanAccent,
                    //       doneWidget: Builder(
                    //         builder: (context) =>
                    //             buildConsumer(context, _product),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
      floatingActionButton: (user.id ==
              Provider.of<CurrentUserProvider>(context, listen: false)
                  .currentUser
                  .id)
          ? FloatingActionButton(
              onPressed: _editData,
              tooltip: _edit ? 'Edit' : "Save",
              child: Icon(!_edit ? Icons.edit : Icons.check),
              backgroundColor: !_edit ? Colors.blue : Colors.green,
            )
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProductEditScreen extends StatelessWidget {
  const ProductEditScreen({
    Key key,
    @required this.user,
    @required bool edit,
    @required TextEditingController nameTextEditingController,
    @required TextEditingController emailTextEditingController,
    @required TextEditingController locationTextEditingController,
  })  : _edit = edit,
        _nameTextEditingController = nameTextEditingController,
        _emailTextEditingController = emailTextEditingController,
        _locationTextEditingController = locationTextEditingController,
        super(key: key);

  final Person user;
  final bool _edit;
  final TextEditingController _nameTextEditingController;
  final TextEditingController _emailTextEditingController;
  final TextEditingController _locationTextEditingController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Profile Image (Image in a field)
            ProfilePicture(
              URL: user.pictureUrl,
              isEditing: _edit,
            ),
            //Name (Text Field)
            ProfileInfo(
              edit: _edit,
              info: user.name,
              title: "Name",
              controller: _nameTextEditingController,
            ),
            //Email (Text Field)
            ProfileInfo(
              edit: _edit,
              info: user.email,
              title: "Description",
              controller: _emailTextEditingController,
            ),
            //Credit (Text Field)
            CreditField(
              info: "10",
              title: user.credit.toString(),
              isEdit: _edit,
            ),
            //Location (Text Field)
            ProfileInfo(
              edit: _edit,
              info: user.location == null ? "Not Known yet" : user.location,
              title: "Location",
              controller: _locationTextEditingController,
            ),
            //List of Products (Button)
            GradientButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(ProductsScreen.routeName, arguments: user.id),
              text: 'List Products',
            ),
            GradientButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(TransactionsPage.routeName),
              text: 'List Transaction',
            ),
          ],
        ),
      ),
    );
  }
}
