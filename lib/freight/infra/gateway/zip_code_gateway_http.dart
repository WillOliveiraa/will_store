import 'package:will_store/freight/domain/entities/zip_code.dart';
import 'package:will_store/freight/infra/http/http_client.dart';
import 'package:will_store/freight/infra/models/zip_code_model.dart';

import '../../../utils/constant.dart';
import '../../application/gateway/zip_code_gateway.dart';

class ZipCodeGatewayHttp implements ZipCodeGateway {
  final HttpClient _httpClient;

  ZipCodeGatewayHttp(this._httpClient);

  @override
  Future<ZipCode?> getZipCode(String code) async {
    final cleanCep = code.replaceAll('.', '').replaceAll('-', '');
    final url = '$urlCepAberto$cleanCep';
    final response = await _httpClient.get(url);
    if (response.isEmpty) throw ArgumentError("CEP not found");
    final zipCode = ZipCodeModel.fromMap(response);
    return zipCode;
  }
}
