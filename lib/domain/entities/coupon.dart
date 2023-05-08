class Coupon {
  final String code;
  final num percentage;
  final DateTime expireDate;

  Coupon(this.code, this.percentage, this.expireDate);

  bool isExpired(DateTime today) {
    return expireDate.isBefore(today);
  }

  num calculateDiscount(num amount) {
    return (amount * percentage) / 100;
  }
}
