import 'Product.dart';

import 'package:shady_market/model/Product.dart';

class CartItem {
  Product product;
  int amount;
  CartItem({this.product, this.amount});
}
