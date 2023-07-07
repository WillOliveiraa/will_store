import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_firebase_functions/mock_firebase_functions.dart';
import 'package:uuid/uuid.dart';
import 'package:will_store/checkout/application/gateways/payment_gateway.dart';
import 'package:will_store/checkout/application/usecases/capture_payment.dart';
import 'package:will_store/checkout/infra/gateways/payment_gateway_http.dart';
import 'package:will_store/utils/constant.dart';

import '../../../mocks/firebase_mock.dart';

void main() async {
  late PaymentGateway paymentGateway;
  late CapturePayment capturePayment;
  final functions = MockFirebaseFunctions();
  final input = const Uuid().v1();
  setupFirebaseAuthMocks();

  setUp(() {
    paymentGateway = PaymentGatewayHttp(functions);
    capturePayment = CapturePayment(paymentGateway);
  });

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  test('Deve capturar um novo pagamento', () async {
    functions.mock(functionNameCapture, (body) async => {'success': true});
    final output = await capturePayment(input);
    expect(output, isTrue);
  });

  test('Deve retornar um erro caso o pagamento não seja capturado', () async {
    functions.mock(
        functionNameCapture,
        (body) async => {
              'success': false,
              'error': {'message': 'Invalid capture payment'}
            });
    expect(
        () async => await capturePayment(input),
        throwsA(isA<ArgumentError>().having(
            (error) => error.message, "message", "Invalid capture payment")));
  });
}
