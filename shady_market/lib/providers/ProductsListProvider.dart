import 'dart:convert';

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

  void fetchProducts() async {
    _prodcuts = [];
    const url = 'http://192.168.1.7:4000/products/';
    var headers = {"offset": "0", "num_of_products": "3"};

    // Sending a POST request with headers
    http.Response response = await http.get(url, headers: headers);
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> data = responseMap['data'];
    data.forEach((e) => _prodcuts.add(Product.fromMap(e)));
    notifyListeners();
  }

  void updateProduct(Product product) async {
    const url = 'http://192.168.1.7:4000/products/';
    var headers = {"Content-type": "application/json"};
    var body = product.toJson();
    http.Response response = await http.post(url, headers: headers, body: body);
    print(response.body);
    int index = _prodcuts.indexOf(product);
    _prodcuts[index] = product;
    
  }

  void deleteProduct(Product product) async {
    const url = 'http://192.168.1.7:4000/products/';
    var headers = {"Content-type": "application/json","id": product.id.toString()};
    http.Response response = await http.delete(url, headers: headers, );
    _prodcuts.remove(product);
    notifyListeners();
  }
}
