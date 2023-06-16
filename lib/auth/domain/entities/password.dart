class Password {
  late String _value;

  Password(String password) {
    if (password.trim().isEmpty ||
        password.length < 6 ||
        password.length > 50) {
      throw ArgumentError('Invalid password');
    }
    _value = password;
  }

  String get value => _value;

  bool get valid => _value.isNotEmpty;
}
