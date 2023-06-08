import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final void Function() closeAction;
  final void Function() buttonAction;
  final String texto1;
  final String texto2;
  final String texto3;

  const DeleteDialog(
      {Key? key,
      required this.closeAction,
      required this.texto1,
      required this.texto2,
      required this.texto3,
      required this.buttonAction})
      : super(key: key);

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
                        SizedBox(height: 30),
                        Text(
                          '${widget.texto2}',
                          style: const TextStyle(
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
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.buttonAction();
                      widget.closeAction();
                    });
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
                Text(
                  '${widget.texto3}',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
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
