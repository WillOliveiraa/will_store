import 'package:will_store/checkout/application/gateways/payment_gateway.dart';
import 'package:will_store/checkout/domain/entities/payment.dart';

class AuthorizePayment {
  final PaymentGateway _paymentGateway;

  AuthorizePayment(this._paymentGateway);

  Future<String> call(Payment payment) async {
    return await _paymentGateway.autorizePayment(payment);
  }
}
