import '../../domain/entities/credit_card.dart';

class CreditCardModel extends CreditCard {
  CreditCardModel({
    required super.number,
    required super.holder,
    required super.expirationDate,
    required super.securityCode,
    required super.brand,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'holder': holder,
      'expirationDate': expirationDate,
      'securityCode': securityCode,
      'brand': brand,
    };
  }

  // factory CreditCardModel.fromMap(Map<String, dynamic> map) {
  //   return CreditCardModel(
  //     number: map['number'] as String,
  //     holder: map['holder'] as String,
  //     expirationDate: map['expirationDate'] as String,
  //     securityCode: map['securityCode'] as String,
  //     brand: map['brand'] as String,
  //   );
  // }
}
