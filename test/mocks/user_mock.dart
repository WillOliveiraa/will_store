import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

final mockUser = MockUser(
  isAnonymous: false,
  uid: "1001",
  email: "will@teste.com",
  displayName: "Willian Oliveira",
);

final List<Map<String, dynamic>> usersMock = [
  {
    "id": "1",
    "firstName": "Willian",
    "lastName": "Oliveira",
    "email": "will@teste.com",
    "cpf": "684.053.160-00",
    "password": "123123"
  },
  {
    "id": "2",
    "firstName": "hcrake0",
    "lastName": "Silva",
    "email": "pbalme0@state.gov",
    "cpf": "407.302.170-27",
    "password": "2a04QuEEAziSK.FfqDOdIQoh..OItIRTfcH7x5E.BcjiOk1V9QMM3J/Oy",
  },
  {
    "id": "3",
    "firstName": "dhaslocke1",
    "lastName": "Santos",
    "email": "eskeats1@census.gov",
    "cpf": "746.971.314-01",
    "password": "2a04LPdY65uGc3zcn2TPR.eR7eNPQLGryNAFyw.J/Z9JByTsCvng0bwIu",
  },
  // {
  //   "id": "4",
  //   "firstName": "gkilsby2",
  //   "lastName": "Alberto",
  //   "email": "ylobbe2@mayoclinic.com",
  //   "cpf": "684.053.160-00",
  //   "password": "2a04GKN98fWbRzHh/WMleC19.u1fh03wDfVD/NcT.ieQTzvm8IQA7PBL6",
  // },
  // {
  //   "id": "5",
  //   "firstName": "stilburn3",
  //   "lastName": "Lemes",
  //   "email": "lzannuto3@guardian.co.uk",
  //   "cpf": "746.971.314-01",
  //   "password": "2a04GKKyRVfACBzpaJyKP3J/tuA2syy5SltKXVxEgoEHeFtaRkvqt/G3e",
  // },
  // {
  //   "id": "6",
  //   "firstName": "cblackhall4",
  //   "lastName": "Martins",
  //   "email": "bryton4@joomla.org",
  //   "cpf": "746.971.314-01",
  //   "password": "2a042Jnmhew/R0NsEGVZT3bFm.lN8GYnjqtwh9HjfeGJujq31GKUyV3Na",
  // }
];
