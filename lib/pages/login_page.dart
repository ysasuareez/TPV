import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restaurante/dialogs/loginDialog.dart';
import 'package:restaurante/pages/order_page.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../models/firebase/employe.dart';
import 'mapa_page.dart';

class LoginPage extends StatefulWidget {
  final void Function() goToMapaPage;

  const LoginPage({Key? key, required this.goToMapaPage}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  bool _obscureText = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'lib/assets/images/fondo_torcido.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 966,
              height: 1244,
              decoration: BoxDecoration(
                color: Colors.white, // Color del container
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/images/logo.png',
                        width: 475,
                      ),
                      Container(
                        width: 466.08,
                        height: 94.24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(47.12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _pinController,
                                readOnly: true,
                                obscureText: _obscureText,
                                decoration: const InputDecoration(
                                  hintText: 'PIN',
                                  hintStyle: TextStyle(fontSize: 30.0),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 210.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: _obscureText
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 200.0, right: 200),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // Color del container
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  buildNumericButton('1', Color(0xFFB0D5FF)),
                                  buildNumericButton('2', Color(0xFF3D8BE7)),
                                  buildNumericButton('3', Color(0xFFB0D5FF)),
                                ],
                              ),
                              SizedBox(height: 2.0),
                              Row(
                                children: [
                                  buildNumericButton('4', Color(0xFF3D8BE7)),
                                  buildNumericButton('5', Color(0xFFB0D5FF)),
                                  buildNumericButton('6', Color(0xFF3D8BE7)),
                                ],
                              ),
                              SizedBox(height: 2.0),
                              Row(
                                children: [
                                  buildNumericButton('7', Color(0xFFB0D5FF)),
                                  buildNumericButton('8', Color(0xFF3D8BE7)),
                                  buildNumericButton('9', Color(0xFFB0D5FF)),
                                ],
                              ),
                              SizedBox(height: 2.0),
                              Row(
                                children: [
                                  buildActionButton('D', Icons.arrow_back),
                                  buildNumericButton('0', Color(0xFFB0D5FF)),
                                  buildActionButton('S', Icons.check),
                                ],
                              ),
                              SizedBox(height: 2.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70.0),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  void comprobarPIN() async {
    if (_pinController.text.isNotEmpty) {
      var _selectedEmployee =
          await getEmployeeByPIN(int.parse(_pinController.text));
      if (_selectedEmployee != null) {
        showDialog(
            context: context,
            builder: (context) => LoginDialog(
                  closeAction: () =>
                      {widget.goToMapaPage(), Navigator.pop(context)},
                  texto1: 'QUE PASES UN FELIZ\n SERVICIO Y RECUERDA:',
                  texto2: 'EL CLIENTE NO SIEMPRE\n LLEVA LA RAZÓN',
                  texto3: 'Vamos a intentar no cargarnos la vajilla',
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => LoginDialog(
                  closeAction: () => Navigator.pop(context),
                  texto1: 'PIN INCORRECTO.',
                  texto2:
                      'ESPERO QUE TE SEPAS EL\n NÚMERO DE LAS MESAS\n MEJOR QUE TU PIN',
                  texto3: '',
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => LoginDialog(
                closeAction: () => Navigator.pop(context),
                texto1: 'PIN INCORRECTO.',
                texto2:
                    'ESPERO QUE TE SEPAS EL\n NÚMERO DE LAS MESAS\n MEJOR QUE TU PIN',
                texto3: 'Vamos a intentar no cargarnos la vajilla',
              ));
    }
  }

  Widget buildNumericButton(String label, Color backgroundColor) {
    return Container(
      width: 175,
      height: 125,
      child: ElevatedButton(
        onPressed: () {
          _pinController.text += label;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget buildActionButton(String label, IconData iconData) {
    return Container(
      width: 175,
      height: 125,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (label == 'D' && _pinController.text.isNotEmpty) {
              _pinController.text = _pinController.text
                  .substring(0, _pinController.text.length - 1);
            } else if (label == 'S') {
              comprobarPIN();
            }
          },
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
                iconData,
                color: Colors.blue,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
