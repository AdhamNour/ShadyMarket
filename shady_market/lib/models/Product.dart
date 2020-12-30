import 'dart:convert';

import 'dart:ffi';

class Product {
  final int id; // the id of the product
  final int owner_id; //the owner id of the product
  final String name; //the name of the product
  final String description; //the description of the product
  final double price; //the price of the product
  final String pictureUrl; //the picture Url of the product
  final String category; //the category of the product
  final String tags; //the tags of the product
  final double rating; //the rating of the product
  final int no_of_rater; // the no_of_rater of the product
  final int quantity; //the quantity of the product
  Product({
    this.id,
    this.owner_id,
    this.name,
    this.description,
    this.price,
    this.pictureUrl,
    this.category,
    this.tags,
    this.rating,
    this.no_of_rater,
    this.quantity,
  });

  Product copyWith({
    int id,
    int owner_id,
    String name,
    String description,
    double price,
    String pictureUrl,
    String category,
    String tags,
    double rating,
    int no_of_rater,
    int quantity,
  }) {
    return Product(
      id: id ?? this.id,
      owner_id: owner_id ?? this.owner_id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      no_of_rater: no_of_rater ?? this.no_of_rater,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_id': owner_id,
      'name': name,
      'description': description,
      'price': price,
      'pictureUrl': pictureUrl,
      'category': category,
      'tags': tags,
      'rating': rating,
      'no_of_rater': no_of_rater,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      id: map['ID'],
      owner_id: map['OwnerID'],
      name: map['name'],
      description: map['Discription'],
      price: double.parse(map['price'].toString()),
      pictureUrl: map['pic'],
      category: map['Category'],
      tags: map['Tags'],
      rating: double.parse(map['rating'].toString()),
      no_of_rater: map['noOfRater'],
      quantity: map['Quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, owner_id: $owner_id, name: $name, description: $description, price: $price, pictureUrl: $pictureUrl, category: $category, tags: $tags, rating: $rating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product &&
        o.id == id &&
        o.owner_id == owner_id &&
        o.name == name &&
        o.description == description &&
        o.price == price &&
        o.pictureUrl == pictureUrl &&
        o.category == category &&
        o.tags == tags &&
        o.rating == rating &&
        o.no_of_rater == no_of_rater &&
        o.quantity == quantity;
  }
}
