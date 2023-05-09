import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../domain/entities/product.dart';

class SaveProduct {
  final ProductRepository _repository;

  SaveProduct(this._repository);

  Future<void> call(Product product) async {
    await _repository.save(product);
  }
}
