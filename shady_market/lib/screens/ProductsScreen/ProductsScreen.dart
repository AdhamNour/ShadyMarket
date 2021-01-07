import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/models/Product.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/screens/ProductEdit/ProductEdit.dart';
import 'package:shady_market/widget/ProductWidget.dart';
import 'package:shady_market/widget/appDrawer.dart';

class ProductsScreen extends StatefulWidget {
  static const String routeName = "/ProductsScreen";

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool showSearchBar = false;
  TextEditingController _searchTextEditingController;
  String felteringString = "";

  void showEditProductScreen(BuildContext context) {
    Navigator.of(context).pushNamed(ProductEdit.routeName);
  }

  @override
  void initState() {
    super.initState();
    _searchTextEditingController = TextEditingController();
    Future.delayed(Duration.zero).then((_)  {
      Provider.of<ProdcutsListProvider>(context,listen: false).fetchProducts();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchTextEditingController.dispose();
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
    if (felteringString.trim().isNotEmpty) {
      List<Product> filteredProducts = [];
      products.forEach((e) {
        print(felteringString.trim());
        print(e.name);
        print((e.name.contains(felteringString.trim())));
        if (e.name.contains(felteringString.trim())) {
          filteredProducts.add(e);
        }
        filteredProducts.forEach((element) {print("\t${element.name}");});
      });
      products = List<Product>.from(filteredProducts);
      products.forEach((e)=>print("\t\t${e.name}"));

    }
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 6 / 10),
        itemBuilder: (context, index) => Provider(
          child: ProductWidget(),
          create: (context) => products[index],
          key: ObjectKey(products[index]),
        ),
        itemCount: products.length,
      ),
      appBar: AppBar(
        title: showSearchBar
            ? TextField(
                controller: _searchTextEditingController,
                onSubmitted: (value) => setState(() => felteringString = value),
              )
            : Text("Products Screen"),
        actions: [
          if (isOwner)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => showEditProductScreen(context),
            ),
          IconButton(
              icon: Icon(showSearchBar ? Icons.cancel : Icons.search),
              onPressed: () {
                setState(() {
                  showSearchBar = !showSearchBar;
                });
              })
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: (isOwner)
          ? FloatingActionButton(
              onPressed: () => showEditProductScreen(context),
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
