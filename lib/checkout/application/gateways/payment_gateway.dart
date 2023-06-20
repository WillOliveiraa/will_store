import '../../domain/entities/payment.dart';

abstract class PaymentGateway {
  Future<String> autorizePayment(Payment payment);
}
