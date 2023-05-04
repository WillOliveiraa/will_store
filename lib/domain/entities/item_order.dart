class OrderItem {
  final String productId;
  final num price;
  final int quantity;

  OrderItem(this.productId, this.price, this.quantity) {
    if (productId.isEmpty) throw ArgumentError("Invalid product id");
    if (price <= 0) throw ArgumentError("Invalid price");
    if (quantity <= 0) throw ArgumentError("Invalid quantity");
  }
}
