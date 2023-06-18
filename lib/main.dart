import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:will_store/catalog/application/usecases/save_product.dart';
import 'package:will_store/catalog/domain/entities/dimentions.dart';
import 'package:will_store/catalog/domain/entities/item_size.dart';
import 'package:will_store/catalog/domain/entities/product.dart';

import 'catalog/infra/factories/database_repository_factory.dart';
import 'utils/database/firebase_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final connection = FirebaseAdapter();
  final storage = FirebaseStorage.instance;
  final repositoryFactory = DatabaseRepositoryFactory(connection, storage);
  SaveProduct saveProduct = SaveProduct(repositoryFactory);
  final product = Product("1", "Product test 1", "Product muito bom", null,
      [ItemSize("1", "P", 19.99, 5, Dimentions("1", 100, 30, 10, 3))]);
  await saveProduct(product);
  runApp(const MyApp());
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
