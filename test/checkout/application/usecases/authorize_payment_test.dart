import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_firebase_functions/mock_firebase_functions.dart';
import 'package:uuid/uuid.dart';
import 'package:will_store/auth/infra/models/user_model.dart';
import 'package:will_store/checkout/application/gateways/payment_gateway.dart';
import 'package:will_store/checkout/application/usecases/authorize_payment.dart';
import 'package:will_store/checkout/infra/gateways/payment_gateway_http.dart';
import 'package:will_store/checkout/infra/models/cielo_payment_model.dart';
import 'package:will_store/checkout/infra/models/credit_card_model.dart';
import 'package:will_store/utils/constant.dart';

import '../../../mocks/firebase_mock.dart';
import '../../../mocks/user_mock.dart';

void main() async {
  late PaymentGateway paymentGateway;
  late AuthorizePayment authorizePayment;
  final functions = MockFirebaseFunctions();
  final input = CieloPaymentModel(
    orderId: '1',
    price: 1500,
    user: UserModel.fromMap(usersMock.first),
    type: CreditCardModel(
      number: "4024 0071 5376 3191",
      // number: "0000 1111 2222 3333 4444",
      holder: "Will Oliveira",
      expirationDate: "12/2025",
      securityCode: "123",
      brand: "VISA",
    ),
  );
  setupFirebaseAuthMocks();

  setUp(() {
    paymentGateway = PaymentGatewayHttp(functions);
    authorizePayment = AuthorizePayment(paymentGateway);
  });

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  test('Deve autorizar um novo pagamento', () async {
    final uuid = const Uuid().v1();
    functions.mock(functionNameAuthorize,
        (body) async => {'success': true, 'paymentId': uuid});
    final output = await authorizePayment(input);
    expect(output, uuid);
  });

  test('Deve retornar um erro caso o pagamento não seja válido', () async {
    functions.mock(
        functionNameAuthorize,
        (body) async => {
              'success': false,
              'error': {'message': 'Invalid payment'}
            });
    expect(
        () async => await authorizePayment(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "Invalid payment")));
  });
}
