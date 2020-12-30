import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/screens/AuthentecationScreen/AuthentecationUI.dart';
import 'package:shady_market/screens/ProductDetailsScreen/ProductDetailsScreen.dart';
import 'package:shady_market/screens/ProductsScreen/ProductsScreen.dart';
import 'package:shady_market/screens/ProfileScreen/ProfileScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp() {
    //initialize user
    // initialize cart
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CurrentUserProvider()),
        ChangeNotifierProvider(create: (ctx) => ProdcutsListProvider()),
      ],
      child: DistributedApplication(),
    );
  }
}

class DistributedApplication extends StatelessWidget {
  const DistributedApplication({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Builder(
        builder: (context) {
          if (Provider.of<CurrentUserProvider>(context).isLogedIn) {
            return ProductsScreen();
          } else {
            return AuthenticationScreen();
          }
        },
      ),
      routes: {
        ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        ProfilePage.routeName: (ctx) => ProfilePage(),
      },
    );
  }
}
