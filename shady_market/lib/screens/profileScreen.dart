import 'package:flutter/material.dart';
import "package:cached_network_image/cached_network_image.dart";
import 'package:shady_market/DATA.dart';
import "package:shady_market/model/Person.dart";

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Person user = ModalRoute.of(context).settings.arguments as Person;
    bool isOwner = user.id == currentUser.id;
    return Scaffold(
      body: new Center(
        child: new ListView(
          children: [
            //Picture
            CachedNetworkImage(
              imageUrl: user.pic,
            ),
            //Name
            Text(
              'Profile Name:' + user.name,
            ),
            //Email
            Text('Location:' + user.email),
            //Location
            Text('Location:' + user.location),
            //Credit
            Text('Location:' + user.credit),
            //List of Transactions
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '/TransactionsScreen'); //For Showing Transactions
              },
              child: Text("Show Transactions"),
            ),
            //List of products Owned
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("/ProductsScreen"); //For Showing Transactions
              },
              child: Text("Show Owned Products"),
            ),
          ],
        ),
      ),
      floatingActionButton: isOwner
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/EditProfileScreen');
              },
              child: Icon(Icons.edit),
            )
          : null,
    );
  }
}
