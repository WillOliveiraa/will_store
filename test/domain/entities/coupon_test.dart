import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/domain/entities/coupon.dart';

void main() {
  test('Deve criar um cupom de desconto válido', () {
    final coupon = Coupon('VALE20', 20, DateTime(2023, 10, 01, 10));
    expect(coupon.isExpired(DateTime(2023, 10, 01, 10)), isFalse);
  });

  test('Deve criar um cupom de desconto inválido', () {
    final coupon = Coupon('VALE20', 20, DateTime(2023, 10, 01, 10));
    expect(coupon.isExpired(DateTime(2023, 10, 03, 10)), isTrue);
  });

  test('Deve calcular o desconto', () {
    final coupon = Coupon('VALE20', 20, DateTime(2023, 10, 01, 10));
    expect(coupon.calculateDiscount(1000), equals(200));
  });
}
