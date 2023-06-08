import 'package:flutter/material.dart';

class WarningDialog extends StatefulWidget {
  final void Function() closeAction;
  final String texto1;

  const WarningDialog({
    Key? key,
    required this.closeAction,
    required this.texto1,
  }) : super(key: key);

  @override
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
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
                  'lib/assets/images/camareros.jpg',
                  width: 600,
                  height: 350,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150.0, right: 150),
                  child: Container(
                    width: 800,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFF7B7B7B),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.texto1}',
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    widget.closeAction();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD056),
                    minimumSize: Size(540, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'OIDO COCINA!',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Text(
                //   '${widget.texto3}',
                //   style: TextStyle(
                //     fontFamily: 'Nunito',
                //     fontSize: 20,
                //     color: Colors.black,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          )),
    );
  }
}
