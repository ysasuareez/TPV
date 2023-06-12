import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:restaurante/firebase_options.dart';
import 'package:restaurante/pages/bbdd_page.dart';
import 'package:restaurante/pages/employees_page.dart';
import 'package:restaurante/pages/login_page.dart';
import 'package:restaurante/pages/mapa_page.dart';
import 'package:restaurante/pages/order_page.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'models/customTable.dart';

void main() async {
  // Inicia Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String timeZone = await FlutterNativeTimezone.getLocalTimezone();
  Intl.defaultLocale = 'es_ES';
  initializeDateFormatting(timeZone).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentPage = 'login';
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

  void _goToBBDDPage() {
    setState(() {
      _currentPage = 'bbdd';
    });
  }

  void _goToEmployeesPage() {
    setState(() {
      _currentPage = 'employees';
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
          goToOrderPage: _goToOrderPage,
          goToLoginPage: _goToLoginPage,
          goToBBDDPage: _goToBBDDPage,
          goToEmployeesPage: _goToEmployeesPage,
        );
        break;
      case 'orders':
        body = OrdersPage(
            table: _table!,
            goToMapaPage: _goToMapaPage,
            goToOrderPage: _goToOrderPage);
        break;
      case 'bbdd':
        body = BBDDPage(
          goToMapaPage: _goToMapaPage,
        );
        break;
      case 'employees':
        body = EmployeesPage(
          goToMapaPage: _goToMapaPage,
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
          toolbarHeight: 0,
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
