import 'package:will_store/auth/infra/models/email_model.dart';

import '../../../checkout/infra/models/cpf_model.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.cpf,
    super.password,
    super.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email.value,
      'cpf': cpf.value,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: EmailModel.fromMap(map),
      cpf: CpfModel.fromMap(map),
      id: map['id'] != null ? map['id'] as String : null,
    );
  }
}
