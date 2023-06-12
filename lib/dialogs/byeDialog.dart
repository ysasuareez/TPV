import 'package:flutter/material.dart';

/// Interactive dialogue with the user to remind them to thank the
/// customer in a funny way.
class ByeDialog extends StatefulWidget {
  const ByeDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ByeDialog> createState() => _ByeDialogState();
}

class _ByeDialogState extends State<ByeDialog> {
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
                  'lib/assets/images/goodbye_marron.jpg',
                  width: 350,
                  height: 350,
                ),
                const SizedBox(height: 45),
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
                          'SIEMPRE DE LAS GRACIAS A\nNUESTROS CLIENTES...',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        Text(
                          '(SI DEJAN PROPINA)',
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xFF7B7B7B),
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD056),
                    minimumSize: const Size(540, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'OIDO COCINA!',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Asegurese de que se han ido para blasfemar',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
