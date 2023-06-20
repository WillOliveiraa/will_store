import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:will_store/checkout/infra/models/cielo_payment_model.dart';

import '../../../utils/constant.dart';
import '../../application/gateways/payment_gateway.dart';
import '../../domain/entities/payment.dart';

class PaymentGatewayHttp implements PaymentGateway {
  final FirebaseFunctions functions;

  PaymentGatewayHttp(this.functions);

  @override
  Future<String> autorizePayment(Payment payment) async {
    // try {
    final paymentData = (payment as CieloPaymentModel).toMapToAuthorize();
    final callable = functions.httpsCallable(functionNameAuthorize);
    final response = await callable.call(paymentData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
    if (data['success']) {
      return data['paymentId'];
    } else {
      // debugPrint('${data['error']['message']}');
      final error = data['error']['message'];
      throw ArgumentError(error);
    }
    // } catch (e) {
    //   throw ArgumentError(e);
    // }
  }
}
