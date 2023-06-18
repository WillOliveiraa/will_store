import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';
import '../factories/repository_factory.dart';

class GetProducts {
  late ProductRepository _repository;

  GetProducts(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<List<Product>> call() async {
    return await _repository.getProducts();
  }
}
