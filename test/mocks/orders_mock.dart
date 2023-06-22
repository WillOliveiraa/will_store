import 'package:cloud_firestore/cloud_firestore.dart';

final ordersMock = [
  {
    "id": "1",
    "cpf": "407.302.170-27",
    "sequence": 1,
    "total": 150,
    "freight": 10,
    "date": Timestamp.fromDate(DateTime(2023, 06, 01, 10, 0, 0)),
    "userId": "1"
  },
  {
    "id": "2",
    "cpf": "407.302.170-27",
    "sequence": 2,
    "total": 100,
    "freight": 10,
    "date": Timestamp.fromDate(DateTime(2023, 06, 01, 11, 0, 0)),
    "userId": "2"
  }
];
