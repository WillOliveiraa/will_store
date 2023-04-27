import '../../domain/entities/product.dart';

abstract class ProductRepository {
  Future<void> save(Product product);
}
