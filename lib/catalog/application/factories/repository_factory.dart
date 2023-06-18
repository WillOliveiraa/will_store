import '../repositories/product_repository.dart';

abstract class RepositoryFactory {
  ProductRepository createProductRepository();
}
