import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';
import '../factories/repository_factory.dart';

class GetProductById {
  late ProductRepository _repository;

  GetProductById(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<Product> call(String id) async {
    return await _repository.getProductById(id);
  }
}
