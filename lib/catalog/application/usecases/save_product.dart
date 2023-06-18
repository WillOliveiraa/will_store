import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';
import '../factories/repository_factory.dart';

class SaveProduct {
  late final ProductRepository _repository;

  SaveProduct(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<String> call(Product product) async {
    return await _repository.save(product);
  }
}
