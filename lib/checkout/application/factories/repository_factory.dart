import 'package:will_store/catalog/application/repositories/product_repository.dart';
import 'package:will_store/checkout/application/repositories/order_repository.dart';

import '../repositories/coupon_repository.dart';

abstract class RepositoryFactory {
  OrderRepository createOrderRepository();
  ProductRepository createProductRepository();
  CouponRepository createCouponRepository();
}
