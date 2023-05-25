import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../../checkout/application/factories/repository_factory.dart';
import '../../domain/entities/product.dart';

class GetProductById {
  late ProductRepository _repository;

  GetProductById(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<Product> call(String id) async {
    return await _repository.getProductById(id);
  }
}
