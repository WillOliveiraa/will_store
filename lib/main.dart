import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:will_store/catalog/application/usecases/save_product.dart';
import 'package:will_store/catalog/domain/entities/dimentions.dart';
import 'package:will_store/catalog/domain/entities/item_size.dart';
import 'package:will_store/catalog/domain/entities/product.dart';

import 'auth/infra/models/user_model.dart';
import 'catalog/infra/factories/database_repository_factory.dart';
import 'checkout/application/usecases/authorize_payment.dart';
import 'checkout/infra/gateways/payment_gateway_http.dart';
import 'checkout/infra/models/cielo_payment_model.dart';
import 'checkout/infra/models/credit_card_model.dart';
import 'utils/database/firebase_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initializeTests();
  initializeTests2();
  runApp(const MyApp());
}

void initializeTests2() async {
  final functions = FirebaseFunctions.instance;
  final input = CieloPaymentModel(
    orderId: '1',
    price: 1500,
    user: UserModel.fromMap(
      {
        "id": "1",
        "firstName": "Willian",
        "lastName": "Oliveira",
        "email": "will@teste.com",
        "cpf": "684.053.160-00",
        "password": "123123"
      },
    ),
    type: CreditCardModel(
      number: "4024 0071 5376 3191",
      // number: "0000 1111 2222 3333 4444",
      holder: "Will Oliveira",
      expirationDate: "12/2025",
      securityCode: "123",
      brand: "VISA",
    ),
  );
  final paymentGateway = PaymentGatewayHttp(functions);
  final authorizePayment = AuthorizePayment(paymentGateway);
  final output = await authorizePayment(input);
  debugPrint(output);
}

void initializeTests() async {
  final connection = FirebaseAdapter();
  final storage = FirebaseStorage.instance;
  final repositoryFactory = DatabaseRepositoryFactory(connection, storage);
  SaveProduct saveProduct = SaveProduct(repositoryFactory);
  final product = Product("1", "Product test 1", "Product muito bom", null,
      [ItemSize("1", "P", 19.99, 5, Dimentions("1", 100, 30, 10, 3))]);
  await saveProduct(product);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
