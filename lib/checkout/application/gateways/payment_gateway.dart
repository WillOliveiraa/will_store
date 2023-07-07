import '../../domain/entities/payment.dart';

abstract class PaymentGateway {
  Future<String> authorizePayment(Payment payment);
  Future<bool> capturePayment(String paymentId);
}
