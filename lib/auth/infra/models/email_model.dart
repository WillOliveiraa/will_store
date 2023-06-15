import '../../domain/entities/email.dart';

class EmailModel extends Email {
  EmailModel(super.email);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': value};
  }

  factory EmailModel.fromMap(Map<String, dynamic> map) {
    return EmailModel(map['email'] as String);
  }
}
