import 'email.dart';

class User {
  final String username;
  final Email email;
  final String? password;
  final String? id;

  User({required this.username, required this.email, this.password, this.id});

  static User create(String email, String password, String username) {
    return User(username: username, email: Email(email), password: password);
  }
}
