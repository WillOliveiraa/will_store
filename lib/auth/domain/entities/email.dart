class Email {
  // ignore: unused_field
  late String _value;

  Email(String email) {
    if (!isValid(email)) throw ArgumentError('Invalid email');
    _value = email;
  }

  bool isValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  String get value => _value;

  bool get valid => _value.isNotEmpty;
}
