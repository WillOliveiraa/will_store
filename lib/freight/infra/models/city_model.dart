import '../../domain/entities/city.dart';

class CityModel extends City {
  CityModel(super.ddd, super.ibge, super.name);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ddd': ddd,
      'ibge': ibge,
      'name': name,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      map['ddd'] as int,
      map['ibge'] as int,
      map['nome'] as String,
    );
  }
}
