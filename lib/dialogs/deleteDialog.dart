import 'package:flutter/material.dart';

///Represents a dialog for confirming the deletion of a command.
class DeleteDialog extends StatefulWidget {
  /// It contains the following properties:
  ///It has a required afirmativeAction parameter, which is a callback function
  ///that will be called when the user confirms the deletion.
  final void Function() afirmativeAction;

  const DeleteDialog({
    Key? key,
    required this.afirmativeAction,
  }) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
          padding: const EdgeInsets.only(
              left: 600.0, right: 600, top: 200, bottom: 160),
          child: Container(
            width: 845,
            height: 990,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                const SizedBox(height: 45),
                Image.asset(
                  'lib/assets/images/basura.jpg',
                  width: 600,
                  height: 370,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 150.0, right: 150),
                  child: Container(
                    width: 800,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFF7B7B7B),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '¡CUIDADO JEFE!',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'ESTÁS A PUNTO DE\nELIMINAR UNA COMANDA',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Close the dialog
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD056),
                        minimumSize: const Size(295, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'CANCELAR',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Calls the afirmativeAction callback provided through the
                    // DeleteDialog widget
                    ElevatedButton(
                      onPressed: () {
                        widget.afirmativeAction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD056),
                        minimumSize: const Size(295, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'CONTINUAR',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          )),
    );
  }
}
