import '../repositories/coupon_repository.dart';

class ValidateCoupon {
  final CouponRepository _repository;

  ValidateCoupon(this._repository);

  Future<bool> call(String code) async {
    final coupon = await _repository.getCoupon(code);
    if (coupon == null) throw ArgumentError("Coupon not found");
    return !coupon.isExpired(DateTime.now());
  }
}
