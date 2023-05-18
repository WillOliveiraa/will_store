import 'package:will_store/freight/application/gateway/zip_code_gateway.dart';
import 'package:will_store/freight/domain/entities/zip_code.dart';

class GetZipCode {
  final ZipCodeGateway _gateway;

  GetZipCode(this._gateway);
  Future<ZipCode?> call(String code) async {
    return await _gateway.getZipCode(code);
  }
}
