import 'package:flutter/material.dart';
import "package:cached_network_image/cached_network_image.dart";
import 'package:shady_market/DATA.dart';
import "package:shady_market/model/Person.dart";

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';
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
              'Profile Name:' + user.name.toString(),
            ),
            //Email
            Text('Email:' + user.email.toString()),
            //Location
            Text('Location:' + user.location.toString()),
            //Credit
            Text('Credit:' + user.credit.toString()),
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
                Navigator.of(context)
                    .pushNamed('/EditProfileScreen', arguments: currentUser);
              },
              child: Icon(Icons.edit),
            )
          : null,
    );
  }
}
