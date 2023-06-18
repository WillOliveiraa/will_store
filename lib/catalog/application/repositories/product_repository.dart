import '../../domain/entities/product.dart';

abstract class ProductRepository {
  Future<String> save(Product product);
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<String> saveImageToStorage(dynamic image, String productId);
  Future<void> updateProductImages(List<String> images, String productId);
}
