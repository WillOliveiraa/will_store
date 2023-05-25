import '../factories/repository_factory.dart';
import '../repositories/coupon_repository.dart';

class ValidateCoupon {
  late CouponRepository _repository;

  ValidateCoupon(RepositoryFactory repositoryFactory) {
    _repository = repositoryFactory.createCouponRepository();
  }

  Future<bool> call(String code) async {
    final coupon = await _repository.getCoupon(code);
    if (coupon == null) throw ArgumentError("Coupon not found");
    return !coupon.isExpired(DateTime.now());
  }
}
