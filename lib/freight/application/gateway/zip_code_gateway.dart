import '../../domain/entities/zip_code.dart';

abstract class ZipCodeGateway {
  Future<ZipCode?> getZipCode(String code);
}
