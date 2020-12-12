import 'dart:convert';

import 'dart:ffi';

class Product {
  final id;
  final owner_Id;
  String discription;
  String pic;
  String category;
  String tags;
  double price;
  double rating;
  int no_raters;
  String name;
  Product(this.id, this.owner_Id, this.discription, this.pic, this.category,
      this.tags, this.price, this.rating, this.no_raters, this.name);
}
