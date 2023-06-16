import 'package:will_store/checkout/domain/entities/cpf.dart';

class CpfModel extends Cpf {
  CpfModel(super.cpf);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'cpf': value};
  }

  factory CpfModel.fromMap(Map<String, dynamic> map) {
    return CpfModel(map['cpf'] as String);
  }
}
