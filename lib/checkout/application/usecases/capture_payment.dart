import 'package:will_store/checkout/application/gateways/payment_gateway.dart';

class CapturePayment {
  final PaymentGateway _paymentGateway;

  CapturePayment(this._paymentGateway);

  Future<bool> call(String paymentId) async {
    return await _paymentGateway.capturePayment(paymentId);
  }
}
