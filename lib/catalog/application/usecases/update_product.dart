import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';
import '../factories/repository_factory.dart';

class UpdateProduct {
  late final ProductRepository _repository;

  UpdateProduct(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<void> call(Product product) async {
    await _repository.update(product);
  }
}
