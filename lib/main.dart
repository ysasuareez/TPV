import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurante/firebase_options.dart';
import 'package:restaurante/pages/login_page.dart';
import 'package:restaurante/pages/mapa_page.dart';
import 'package:restaurante/pages/order_page.dart';

import 'models/firebase/customTable.dart';
import 'models/firebase/employe.dart';

void main() async {
  // Inicia Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentPage = 'login';
  Employee? _selectedEmployee;
  CustomTable? _table;

  void _goToLoginPage() {
    setState(() {
      _currentPage = 'login';
    });
  }

  void _goToMapaPage() {
    setState(() {
      _currentPage = 'mapa';
    });
  }

  void _goToOrderPage(CustomTable table) {
    setState(() {
      _currentPage = 'orders';
      _table = table;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_currentPage) {
      case 'login':
        body = LoginPage(goToMapaPage: _goToMapaPage);
        break;
      case 'mapa':
        body = MapaPage(
          goToOrdersPage: _goToOrderPage,
        );
        break;
      case 'orders':
        body = OrdersPage(
          table: _table!,
          goToMapaPage: _goToMapaPage,
          goToOrderPage: _goToOrderPage,
        );
        break;
      default:
        body = Container();
    }

    return MaterialApp(
      title: 'TPV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'BELYNDAS',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), // Color del container
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body: body,
      ),
    );
  }
}
