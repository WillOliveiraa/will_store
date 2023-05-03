import '../../domain/entities/product.dart';

abstract class ProductRepository {
  Future<void> save(Product product);
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
}
