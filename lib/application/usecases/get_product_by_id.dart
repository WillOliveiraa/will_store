import 'package:will_store/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';

class GetProductById {
  final ProductRepository _repository;

  GetProductById(this._repository);

  Future<Product> call(String id) async {
    return await _repository.getProductById(id);
  }
}
