import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:will_store/application/repositories/coupon_repository.dart';
import 'package:will_store/domain/entities/coupon.dart';
import 'package:will_store/infra/database/connection.dart';

import '../models/coupon_model.dart';

class CouponRepositoryDatabase implements CouponRepository {
  final Connection _connection;
  final couponsCollection = "coupons";

  CouponRepositoryDatabase(this._connection);

  @override
  Future<Coupon?> getCoupon(String code) async {
    final queryData = await _connect
        .collection(couponsCollection)
        .where('code', isEqualTo: code)
        .get();
    if (queryData.docs.isEmpty) return null;
    final couponData =
        queryData.docs.firstWhere((element) => element['code'] == code);
    if (!couponData.exists) return null;
    return CouponModel.fromMap(_setId(couponData));
  }

  FirebaseFirestore get _connect =>
      (_connection.connect() as FirebaseFirestore);

  Map<String, dynamic> _setId(DocumentSnapshot<Object?> couponData) {
    final data = couponData.data() as Map<String, dynamic>;
    data['id'] = couponData.id;
    return data;
  }
}
