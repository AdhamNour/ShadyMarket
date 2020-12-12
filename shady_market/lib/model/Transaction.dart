class Transaction {
  final id;
  final product; //array of productIDs
  final buyer;
  final quantity; // array of quantity

  Transaction({this.id, this.product, this.buyer, this.quantity});
}
