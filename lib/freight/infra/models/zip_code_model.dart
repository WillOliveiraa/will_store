import 'package:will_store/freight/domain/entities/zip_code.dart';
import 'package:will_store/freight/infra/models/city_model.dart';
import 'package:will_store/freight/infra/models/coord_model.dart';
import 'package:will_store/freight/infra/models/uf_model.dart';

class ZipCodeModel extends ZipCode {
  ZipCodeModel(super.code, super.street, super.neighborhood, super.city,
      super.uf, super.lat, super.long);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'street': street,
      'neighborhood': neighborhood,
      'city': (city as CityModel).toMap(),
      'uf': (uf as UfModel).toMap(),
      'coord': (coord as CoordModel).toMap(),
    };
  }

  factory ZipCodeModel.fromMap(Map<String, dynamic> map) {
    return ZipCodeModel(
      map['cep'] as String,
      map['logradouro'] as String,
      map['bairro'] as String,
      CityModel.fromMap(map['cidade'] as Map<String, dynamic>),
      UfModel.fromMap(map['estado'] as Map<String, dynamic>),
      double.tryParse(map['latitude'])!,
      double.tryParse(map['longitude'])!,
    );
  }
}
