import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/coupon.dart';

class CouponModel extends Coupon {
  CouponModel(super.code, super.percentage, super.expireDate);

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      map['code'] as String,
      map['percentage'] as num,
      (map['expireDate'] as Timestamp).toDate(),
    );
  }
}
