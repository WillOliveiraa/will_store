class CartItem {
  final String? id;
  final String productId;
  final String userId;
  final int quantity;
  final String sizeName;

  CartItem({
    this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.sizeName,
  }) {
    if (productId.trim().isEmpty) throw ArgumentError('Invalid product id');
    if (userId.trim().isEmpty) throw ArgumentError('Invalid user id');
    if (quantity.isNegative || quantity == 0) {
      throw ArgumentError('Invalid quantity');
    }
    if (sizeName.trim().isEmpty) throw ArgumentError('Invalid size name');
  }
}
