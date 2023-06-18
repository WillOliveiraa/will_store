import 'package:firebase_storage/firebase_storage.dart';
import 'package:will_store/catalog/application/repositories/product_repository.dart';

import '../../../catalog/infra/repositories/product_repository_database.dart';
import '../../../utils/database/database_connection.dart';
import '../../application/factories/repository_factory.dart';

class DatabaseRepositoryFactory implements RepositoryFactory {
  final DatabaseConnection _connection;
  final FirebaseStorage _storage;

  DatabaseRepositoryFactory(this._connection, this._storage);

  @override
  ProductRepository createProductRepository() {
    return ProductRepositoryDatabase(_connection, _storage);
  }
}
