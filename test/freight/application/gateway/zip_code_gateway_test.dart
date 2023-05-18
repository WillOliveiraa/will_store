import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/application/gateway/zip_code_gateway.dart';
import 'package:will_store/freight/application/usecases/get_zip_code.dart';
import 'package:will_store/freight/infra/gateway/zip_code_gateway_http.dart';
import 'package:will_store/freight/infra/http/dio_adapter.dart';

void main() async {
  late ZipCodeGateway gateway;
  late DioAdapter dioAdapter;
  late GetZipCode getZipCode;

  setUp(() {
    dioAdapter = DioAdapter();
    gateway = ZipCodeGatewayHttp(dioAdapter);
    getZipCode = GetZipCode(gateway);
  });

  test("Deve buscar um CEP", () async {
    const input = "87035-270";
    final output = await getZipCode(input);
    expect(output?.street, equals("Rua Pioneiro Alfredo José da Costa"));
    expect(output?.neighborhood, equals("Jardim Alvorada"));
    expect(output?.uf.name, equals("Paraná"));
  });

  test("Não deve buscar um CEP inválido", () async {
    const input = "00000-000";
    expect(
        () async => getZipCode(input),
        throwsA(isA<ArgumentError>()
            .having((error) => error.message, "message", "CEP not found")));
  });
}
