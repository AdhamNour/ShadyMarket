import 'package:flutter/widgets.dart';
import 'package:shady_market/models/Product.dart';

class ProdcutsListProvider extends ChangeNotifier {
  List<Product> _prodcuts = List.generate(
      100,
      (index) => Product(
          id: index,
          category: 'test',
          description: "this is a testing product",
          name: "Testing Product",
          no_of_rater: 10,
          owner_id: 1,
          pictureUrl:
              'https://cdn.myanimelist.net/images/anime/1384/107759l.webp',
          price: 100,
          quantity: 10,
          rating: 5,
          tags: 'Testing'));

  List<Product> get prodcuts {
    return [..._prodcuts];
  }

  void set products(List<Product> iProdcuts) {
    _prodcuts = iProdcuts;
  }
}
