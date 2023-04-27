import 'package:will_store/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';

class GetProducts {
  final ProductRepository _repository;

  GetProducts(this._repository);

  Future<List<Product>> call() async {
    return await _repository.getProducts();
  }
}
