import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/checkout/application/factories/repository_factory.dart';
import 'package:will_store/checkout/application/repositories/coupon_repository.dart';
import 'package:will_store/checkout/application/repositories/order_repository.dart';

import '../../../catalog/infra/repositories/product_repository_database.dart';
import '../../../core/database/database_connection.dart';
import '../../infra/repositories/coupon_repository_database.dart';
import '../../infra/repositories/order_repository_database.dart';

class DatabaseRepositoryFactory implements RepositoryFactory {
  final DatabaseConnection _connection;

  DatabaseRepositoryFactory(this._connection);

  @override
  OrderRepository createOrderRepository() {
    return OrderRepositoryDatabase(_connection);
  }

  @override
  CouponRepository createCouponRepository() {
    return CouponRepositoryDatabase(_connection);
  }

  @override
  ProductRepository createProductRepository() {
    return ProductRepositoryDatabase(_connection);
  }
}
