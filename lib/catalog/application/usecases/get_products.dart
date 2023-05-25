import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../../checkout/application/factories/repository_factory.dart';
import '../../domain/entities/product.dart';

class GetProducts {
  late ProductRepository _repository;

  GetProducts(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createProductRepository();
  }

  Future<List<Product>> call() async {
    return await _repository.getProducts();
  }
}
