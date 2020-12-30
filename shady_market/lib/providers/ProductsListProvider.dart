import 'package:flutter/widgets.dart';
import 'package:shady_market/models/Product.dart';
import 'package:http/http.dart' as http;

class ProdcutsListProvider extends ChangeNotifier {
  List<Product> _prodcuts = [];

  List<Product> get prodcuts {
    return [..._prodcuts];
  }

  void set products(List<Product> iProdcuts) {
    _prodcuts = iProdcuts;
  }

  void fetchProducts() {
// add products here <3
  }
}
