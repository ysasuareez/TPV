import 'package:flutter/material.dart';

import '../models/firebase/customTable.dart';
import 'cashDialog.dart';

class PaymentDialog extends StatefulWidget {
  final void Function() cardAction;

  final CustomTable table;

  const PaymentDialog({Key? key, required this.cardAction, required this.table})
      : super(key: key);

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  int currentTableIndex = 0;
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
                  'lib/assets/images/dinero1.jpg',
                  width: 350,
                  height: 350,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 150.0, right: 150),
                  child: Container(
                    width: 800,
                    height: 375,
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
                          'MESA ${widget.table.id}',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                        const Text(
                          'SELECCIONE\nTIPO DE PAGO',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.cardAction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFE1B8),
                        minimumSize: Size(295, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'TARJETA',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        // Acción cuando se selecciona 'EFECTIVO'
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CashDialog(
                            table: widget.table,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD056),
                        minimumSize: const Size(295, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'EFECTIVO',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
