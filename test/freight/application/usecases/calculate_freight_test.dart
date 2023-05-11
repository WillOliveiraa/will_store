import 'package:flutter_test/flutter_test.dart';
import 'package:will_store/freight/application/models/calculate_freight_input.dart';
import 'package:will_store/freight/application/models/calculate_freight_item.dart';
import 'package:will_store/freight/application/repositories/zip_code_repository.dart';
import 'package:will_store/freight/application/usecases/calculate_freight.dart';
import 'package:will_store/freight/domain/entities/zip_code.dart';

class ImplementsRepository implements ZipCodeRepository {
  @override
  Future<ZipCode?> getZipCode(String code) async {
    if (code == "22060030") {
      return ZipCode(
          "22060030", "Rua Aires Saldanha", "Copacabana", -27.5945, -48.5477);
    }
    if (code == "88015600") {
      return ZipCode(
          "88015600", "Rua Aires Saldanha", "Copacabana", -22.9129, -43.2003);
    }
    return null;
  }
}

void main() {
  late ZipCodeRepository repository;
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
