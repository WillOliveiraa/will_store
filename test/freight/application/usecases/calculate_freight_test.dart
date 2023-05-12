import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/application/gateway/zip_code_gateway.dart';
import 'package:will_store/freight/application/models/calculate_freight_input.dart';
import 'package:will_store/freight/application/models/calculate_freight_item.dart';
import 'package:will_store/freight/application/usecases/calculate_freight.dart';
import 'package:will_store/freight/domain/entities/zip_code.dart';
import 'package:will_store/freight/infra/models/city_model.dart';
import 'package:will_store/freight/infra/models/uf_model.dart';
import 'package:will_store/freight/infra/models/zip_code_model.dart';

class ImplementsRepository implements ZipCodeGateway {
  @override
  Future<ZipCode?> getZipCode(String code) async {
    if (code == "22060030") {
      return ZipCodeModel(
        "22060030",
        "Rua Aires Saldanha",
        "Copacabana",
        CityModel(1, "asd", "Rio de Janeiro"),
        UfModel("Rio de Janeiro", "RJ"),
        -27.5945,
        -48.5477,
      );
    }
    if (code == "88015600") {
      return ZipCode(
        "88015600",
        "Rua Almirante Lamego",
        "Centro",
        CityModel(1, "asd", "Florianópolis"),
        UfModel("Santa Catarina", "SC"),
        -22.9129,
        -43.2003,
      );
    }
    return null;
  }
}

void main() {
  late ZipCodeGateway repository;
  late CalculateFreight calculateFreight;

  setUpAll(() {
    repository = ImplementsRepository();
    calculateFreight = CalculateFreight(repository);
  });

  test(
      'Deve calcular o frete para um pedido com 3 itens sem cep de origem e destino',
      () async {
    final input = CalculateFreightInput(
        [CalculateFreightItem(100, 30, 10, 3, 2)], null, null);
    final output = await calculateFreight(input);
    expect(output['freight'], equals(60));
  });

  test(
      'Deve calcular o frete para um pedido com 3 itens com cep de origem e destino',
      () async {
    final input = CalculateFreightInput(
        [CalculateFreightItem(100, 30, 10, 3, 1)], "22060030", "88015600");
    final output = await calculateFreight(input);
    expect(output['freight'], equals(22.446653340244893));
  });
}
