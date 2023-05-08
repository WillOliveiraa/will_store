import '../../domain/entities/coupon.dart';

abstract class CouponRepository {
  Future<Coupon?> getCoupon(String code);
}
