import 'package:will_store/auth/domain/entities/password.dart';
import 'package:will_store/checkout/domain/entities/cpf.dart';

import 'email.dart';

class User {
  final String firstName;
  final String lastName;
  final Email email;
  final Cpf cpf;
  final Password? password;
  final String? id;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.cpf,
    this.password,
    this.id,
  });

  static User create({
    required String firstName,
    required String lastName,
    required String email,
    required String cpf,
    required String password,
    String? id,
  }) {
    if (firstName.trim().isEmpty) throw ArgumentError('Invalid first name');
    if (lastName.trim().isEmpty) throw ArgumentError('Invalid last name');
    return User(
      firstName: firstName,
      lastName: lastName,
      cpf: Cpf(cpf),
      email: Email(email),
      password: Password(password),
      id: id,
    );
  }
}
