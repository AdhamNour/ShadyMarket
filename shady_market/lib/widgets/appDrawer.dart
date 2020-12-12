import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shady_market/DATA.dart';
import 'package:shady_market/screens/profileScreen.dart';

class ANAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('welcome back'),
            automaticallyImplyLeading: false,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(currentUser ==
                              null
                          ? 'data:image/png;base64,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'
                          : currentUser.pic)),
                  title: Text(currentUser == null ? 'error' : currentUser.name),
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName,
                        arguments: currentUser);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.shopping_basket),
                  title: Text('All Products'),
                  onTap: () => Navigator.of(context).pushReplacementNamed('/'),
                ),
                Divider(),
                ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Your Shopping cart'),
                    onTap: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushNamed(CartScreen.routeName);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Row(
                        children: [
                          Icon(Icons.alarm),
                          Text("this feature is under implementation")
                        ],
                      )));
                    }),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Your Favorites'),
                  onTap: () {
                    Navigator.of(context).pop();
                    //Navigator.of(context).pushNamed(FavoritesScreen.routeName);
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Row(
                      children: [
                        Icon(Icons.alarm),
                        Text("this feature is under implementation")
                      ],
                    )));
                  },
                ),
                ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Your Orders'),
                    onTap: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushNamed(OrdersScreen.routeName);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Row(
                        children: [
                          Icon(Icons.alarm),
                          Text("this feature is under implementation")
                        ],
                      )));
                    }),
                Divider(),
                ListTile(
                    leading: Icon(Icons.add_shopping_cart),
                    title: Text('your product'),
                    onTap: () {
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushNamed(UserProductsScreen.routename);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Row(
                        children: [
                          Icon(Icons.alarm),
                          Text("this feature is under implementation")
                        ],
                      )));
                    }),
                Divider(),
                ...List<Widget>.generate(
                    10,
                    (index) => ListTile(
                          leading: Icon(Icons.apps),
                          title: Text('Shop section no. $index'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('it is just a place holder')));
                          },
                        )),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                  onTap: () {},
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
