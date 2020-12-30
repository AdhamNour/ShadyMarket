import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/screens/ProfileScreen/ProfileScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUserProvider>(context).currentUser;

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
                      backgroundImage: CachedNetworkImageProvider(currentUser
                                  .pictureUrl ==
                              null
                          ? 'https://avatarfiles.alphacoders.com/183/thumb-1920-183822.jpg'
                          : currentUser.pictureUrl)),
                  title: Text(
                      currentUser.name == null ? 'error' : currentUser.name),
                  onTap: currentUser.name != null
                      ? () {
                          Navigator.of(context).pushNamed(ProfilePage.routeName,
                              arguments: currentUser);
                        }
                      : null,
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
