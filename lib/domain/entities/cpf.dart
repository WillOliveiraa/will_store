const cleanRegex = r'[^\d]';

class Cpf {
  final String _cpf;
  late String _value;

  Cpf(this._cpf) {
    if (_cpf.isEmpty || !validate(_cpf)) throw ArgumentError("Invalid cpf");
    _value = _cpf;
  }

  int _calculateDigit(String cpf, int factor) {
    int total = 0;
    for (final digit in cpf.split('')) {
      if (factor > 1) total += int.parse(digit) * factor--;
    }
    final rest = total % 11;
    return (rest < 2) ? 0 : 11 - rest;
  }

  String _clean(String cpf) {
    return cpf.replaceAll(RegExp(cleanRegex), "");
  }

  bool _isValidLength(String cpf) {
    return cpf.length != 11;
  }

  bool _allDigitsTheSame(String cpf) {
    return cpf.split("").every((c) => c == cpf[0]);
  }

  String _extractCheckDigit(String cpf) {
    return cpf.substring(cpf.length - 2, cpf.length);
  }

  bool validate(String cpf) {
    if (cpf.isEmpty) return false;
    cpf = _clean(cpf);
    if (_isValidLength(cpf)) return false;
    if (_allDigitsTheSame(cpf)) return false;
    final digit1 = _calculateDigit(cpf, 10);
    final digit2 = _calculateDigit(cpf, 11);
    final actualDigit = _extractCheckDigit(cpf);
    final calculatedDigit = "$digit1$digit2";
    return actualDigit == calculatedDigit;
  }

  String get value => _value;
}
