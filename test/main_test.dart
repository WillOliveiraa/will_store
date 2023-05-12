import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/application/gateway/zip_code_gateway.dart';
import 'package:will_store/freight/infra/gateway/zip_code_gateway_http.dart';
import 'package:will_store/freight/infra/http/dio_adapter.dart';

void main() async {
  late ZipCodeGateway gateway;
  late DioAdapter dioAdapter;

  setUp(() {
    dioAdapter = DioAdapter();
    gateway = ZipCodeGatewayHttp(dioAdapter);
  });

  test("Deve buscar um CEP", () async {
    const input = "87035-270";
    final output = await gateway.getZipCode(input);
    expect(output?.street, equals("Rua Pioneiro Alfredo José da Costa"));
    expect(output?.neighborhood, equals("Jardim Alvorada"));
    expect(output?.uf.name, equals("Paraná"));
  });
}
