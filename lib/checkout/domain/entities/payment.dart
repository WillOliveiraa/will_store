import 'package:will_store/auth/domain/entities/user.dart';
import 'package:will_store/checkout/domain/entities/payment_type.dart';

class Payment {
  final String orderId;
  final num price;
  final User user;
  final PaymentType type;

  Payment({
    required this.orderId,
    required this.price,
    required this.user,
    required this.type,
  });
}
