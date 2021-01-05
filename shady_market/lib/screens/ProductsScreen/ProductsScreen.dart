import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/screens/ProductEdit/ProductEdit.dart';
import 'package:shady_market/widget/ProductWidget.dart';
import 'package:shady_market/widget/appDrawer.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = "/ProductsScreen";
  void showEditProductScreen(BuildContext context) {
    Navigator.of(context).pushNamed(ProductEdit.routeName);
  }
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProdcutsListProvider>(context).prodcuts;
    final id = ModalRoute.of(context).settings.arguments as int;
    bool isOwner =
        id == Provider.of<CurrentUserProvider>(context).currentUser.id;
    if (id != null) {
      List<Product> filteredProducts = [];
      products.forEach((e) {
        if (e.owner_id == id) {
          filteredProducts.add(e);
        }
      });
      products = filteredProducts;
    }
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 6 / 10),
        itemBuilder: (context, index) => Provider(
          child: ProductWidget(),
          create: (context) => products[index],
        ),
        itemCount: products.length,
      ),
      appBar: AppBar(
        title: Text("Products Screen"),
        actions: [
          if (isOwner) IconButton(icon: Icon(Icons.add), onPressed: () => showEditProductScreen(context),)
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: (isOwner)? FloatingActionButton(
        onPressed: () => showEditProductScreen(context),
        child: Icon(Icons.add),
      ):null,
    );
  }
}
