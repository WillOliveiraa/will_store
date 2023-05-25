import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';

import '../../domain/entities/product.dart';

class SaveProduct {
  late ProductRepository _repository;

  SaveProduct(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<void> call(Product product) async {
    await _repository.save(product);
  }
}
