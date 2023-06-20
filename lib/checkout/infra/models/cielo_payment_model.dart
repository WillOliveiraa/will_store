import '../../../utils/constant.dart';
import '../../domain/entities/cielo_payment.dart';
import 'credit_card_model.dart';

class CieloPaymentModel extends CieloPayment {
  CieloPaymentModel({
    required super.orderId,
    required super.price,
    required super.user,
    required super.type,
  });

  Map<String, dynamic> toMapToAuthorize() {
    return <String, dynamic>{
      'merchantOrderId': orderId,
      'amount': (price * 100).toInt(),
      'softDescriptor': appName,
      'installments': 1,
      'creditCard': (type as CreditCardModel).toMap(),
      'cpf': user.cpf.value,
      'paymentType': 'CreditCard',
    };
  }

  // factory Payment.fromMap(Map<String, dynamic> map) {
  //   return Payment(
  //     orderId: map['orderId'] as String,
  //     price: map['price'] as num,
  //     user: User.fromMap(map['user'] as Map<String, dynamic>),
  //     type: PaymentType.fromMap(map['type'] as Map<String, dynamic>),
  //   );
  // }
}
