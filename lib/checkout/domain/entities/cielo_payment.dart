import 'payment.dart';

class CieloPayment extends Payment {
  CieloPayment({
    required super.orderId,
    required super.price,
    required super.user,
    required super.type,
  });
}
