import 'package:flutter/material.dart';

/// Represents a dialog for moving an item or performing an action.
class MoveDialog extends StatefulWidget {
  /// It contains the following properties:
  /// noAction and yesAction: two callbacks functios that will be invoked when the user press
  /// the button YES or NO.
  final void Function() noAction;
  final void Function() yesAction;

  /// textoAUX and texto1: string that represents additional text content
  /// for the dialog and a string that represents the main text content
  /// for the dialog.
  final String textoAUX;
  final String texto1;

  const MoveDialog({
    Key? key,
    required this.noAction,
    required this.texto1,
    required this.textoAUX,
    required this.yesAction,
  }) : super(key: key);

  @override
  State<MoveDialog> createState() => _MoveDialogState();
}

class _MoveDialogState extends State<MoveDialog> {
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
                const SizedBox(height: 30),
                Image.asset(
                  'lib/assets/images/mover.jpg',
                  width: 600,
                  height: 400,
                ),
                const SizedBox(height: 15),
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
                      children: [
                        Text(
                          widget.texto1,
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.textoAUX,
                          style: const TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFF7B7B7B),
                          indent: 50,
                          endIndent: 50,
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          '¿DESEA CONTINUAR?',
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
                    ElevatedButton(
                      onPressed: () {
                        widget.noAction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE1B8),
                        minimumSize: const Size(295, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'NO',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        widget.yesAction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD056),
                        minimumSize: const Size(295, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'SI',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
