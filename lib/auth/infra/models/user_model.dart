import 'package:will_store/auth/infra/models/email_model.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.username,
    required super.email,
    super.password,
    super.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': (email as EmailModel).toMap(),
      'password': password,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: EmailModel.fromMap(map),
      password: map['password'] != null ? map['password'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }
}
