import 'payment_type.dart';

class CreditCard extends PaymentType {
  final String number;
  final String holder;
  final String expirationDate;
  final String securityCode;
  final String brand;

  CreditCard({
    required this.number,
    required this.holder,
    required this.expirationDate,
    required this.securityCode,
    required this.brand,
  });
}
