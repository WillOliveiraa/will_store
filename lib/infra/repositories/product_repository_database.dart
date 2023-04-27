import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/infra/database/connection.dart';

import '../../application/repositories/product_repository.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryDatabase implements ProductRepository {
  final Connection _connection;

  ProductRepositoryDatabase(this._connection);

  @override
  Future<void> save(Product product) async {
    final connect = (_connection.connect() as FirebaseFirestore);
    final productCollection = connect.collection('products');
    await productCollection.add({
      'name': product.name,
      'description': product.description,
      'size': product.size,
      'images': product.images,
    });
  }
}
