import 'package:flutter/material.dart';

import '../dialogs/loginDialog.dart';
import '../services/firebase_service.dart';

/// Represents a button pad for entering a PIN or Cuantity.
/// It is used in a login or cash dialog.
class Botonera extends StatefulWidget {
  /// It contains the following properties:

  /// Controls the input text field for the PIN code.
  final TextEditingController pinController;

  /// A callback function that is called when the user successfully logs in
  /// and needs to navigate to another page.
  final void Function() goToMapaPage;

  /// A string that represents the text of a special button
  /// (".", "D", or "S").
  final String text;

  ///SIZE BUTTONS
  final double w;
  final double h;

  const Botonera({
    Key? key,
    required this.pinController,
    required this.text,
    required this.goToMapaPage,
    required this.w,
    required this.h,
  }) : super(key: key);
  @override
  BotoneraState createState() => BotoneraState();
}

class BotoneraState extends State<Botonera> {
  Color azulOscuro = const Color(0xFF3D8BE7);
  Color azulClaro = const Color(0xFFB0D5FF);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildNumericButton('1', azulClaro),
            buildNumericButton('2', azulOscuro),
            buildNumericButton('3', azulClaro),
          ],
        ),
        const SizedBox(height: 2.0),
        Row(
          children: [
            buildNumericButton('4', azulOscuro),
            buildNumericButton('5', azulClaro),
            buildNumericButton('6', azulOscuro),
          ],
        ),
        const SizedBox(height: 2.0),
        Row(
          children: [
            buildNumericButton('7', azulClaro),
            buildNumericButton('8', azulOscuro),
            buildNumericButton('9', azulClaro),
          ],
        ),
        const SizedBox(height: 2.0),
        Row(
          children: [
            buildActionButton('D', Icons.arrow_back),
            buildNumericButton('0', azulClaro),
            lateBotton(),
          ],
        ),
        const SizedBox(height: 2.0),
      ],
    );
  }

  /// A method that builds a numeric button widget with the provided label and
  /// backgroundColor. When pressed, it appends the corresponding number to
  /// the pinController.
  Widget buildNumericButton(String label, Color backgroundColor) {
    return Container(
      width: widget.w,
      height: widget.h,
      child: ElevatedButton(
        onPressed: () {
          widget.pinController.text += label;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 70, color: Colors.black),
        ),
      ),
    );
  }

  /// A method that builds an action button widget with the provided label
  /// and iconData. It performs different actions based on the label value.
  Widget buildActionButton(String label, IconData iconData) {
    return Container(
      width: widget.w,
      height: widget.h,
      decoration: BoxDecoration(
        color: azulOscuro,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            /// If the text property is ".", it appends the label to the
            ///  pinController
            if (widget.text == '.') {
              widget.pinController.text += label;
            } else {
              /// If the label is "D" (delete), it removes the last character
              ///  from the pinController
              if (label == 'D' && widget.pinController.text.isNotEmpty) {
                widget.pinController.text = widget.pinController.text
                    .substring(0, widget.pinController.text.length - 1);

                /// If the label is "S" (submit), it triggers the
                ///  comprobarPIN method.
              } else if (label == 'S') {
                checkPIN();
              }
            }
          },
          child: Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
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

  /// A method that asynchronously verifies the entered PIN code. It calls
  /// the getEmployeeByPIN method from the firebase_service file to fetch an
  /// employee based on the entered PIN. If a valid employee is found, it
  /// shows a login dialog using the LoginDialog widget. Otherwise,
  /// it shows a funy error dialog.
  void checkPIN() async {
    if (widget.pinController.text.isNotEmpty) {
      var selectedEmployee =
          await getEmployeeByPIN(int.parse(widget.pinController.text));
      if (selectedEmployee != null) {
        showDialog(
            context: context,
            builder: (context) => LoginDialog(
                  closeAction: () {
                    widget.goToMapaPage();
                    Navigator.pop(context);
                  },
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

  /// A method that returns a specific button widget based on the value of the
  /// text property. If the text is ".", it returns a numeric button with a dot.
  /// Otherwise, it returns an action button with the text as the label and
  /// a checkmark icon.
  Widget lateBotton() {
    if (widget.text == '.') {
      return buildNumericButton('.', const Color(0xFF3D8BE7));
    } else {
      return buildActionButton(widget.text, Icons.check);
    }
  }
}
