import '../../domain/entities/password.dart';

class PasswordModel extends Password {
  PasswordModel(super.password);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'password': value};
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      map['password'] as String,
    );
  }
}
