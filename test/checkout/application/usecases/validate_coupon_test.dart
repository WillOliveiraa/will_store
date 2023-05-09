import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/checkout/application/repositories/coupon_repository.dart';
import 'package:will_store/checkout/application/usecases/validate_coupon.dart';
import 'package:will_store/checkout/infra/repositories/coupon_repository_database.dart';
import 'package:will_store/core/database/fake_farebase_adapter.dart';

import '../../../mocks/coupons_mock.dart';

void main() {
  final connection = FakeFirebaseAdapter();
  late CouponRepository repository;
  late ValidateCoupon validateCoupon;
  final List<Map<String, dynamic>> couponsSnap = [];

  setUp(() {
    repository = CouponRepositoryDatabase(connection);
    validateCoupon = ValidateCoupon(repository);
  });

  setUp(() async {
    final collection = connection.firestore.collection('coupons');
    for (int i = 0; i < couponsMock.length; i++) {
      final snapshot = await collection.add(couponsMock[i]);
      final couponMock = couponsMock[i];
      couponMock['id'] = snapshot.id;
      couponsSnap.add(couponMock);
    }
  });

  test('Deve validar um cupom de desconto válido', () async {
    const input = "VALE20";
    final output = await validateCoupon(input);
    expect(output, isTrue);
  });

  test('Deve validar um cupom de desconto expirdao', () async {
    const input = "VALE10";
    final output = await validateCoupon(input);
    expect(output, isFalse);
  });

  test("Não deve validar um cupom de desconto não encontrado", () {
    const input = "VALE50";
    expect(
        () async => await validateCoupon(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Coupon not found")));
  });
}
