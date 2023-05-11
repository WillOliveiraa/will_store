import '../../domain/entities/zip_code.dart';

abstract class ZipCodeRepository {
  Future<ZipCode?> getZipCode(String code);
}
