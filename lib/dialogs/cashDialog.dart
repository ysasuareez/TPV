import 'package:flutter/material.dart';

import '../models/customTable.dart';
import '../utils/botonera.dart';

/// Interactive dialogue for the user to quickly access the total amount to be
/// paid by the customer, enter the received money, and in turn, get the change
/// without the need for calculations. If the user enters an amount less than
/// required, the bill cannot be collected, and therefore, the dialogue will
/// not disappear.
class CashDialog extends StatefulWidget {
  /// It contains the following properties:
  /// cobrarAction: which is a callback function
  ///  to be executed when the payment is completed
  final void Function() cobrarAction;

  /// table: which represents the table.
  final CustomTable table;

  const CashDialog({
    Key? key,
    required this.table,
    required this.cobrarAction,
  }) : super(key: key);

  @override
  State<CashDialog> createState() => _CashPaymentDialogState();
}

class _CashPaymentDialogState extends State<CashDialog> {
  /// It contains a TextEditingController named _cashController to handle the
  /// input for the cash amount. The cashValue variable represents the amount of
  /// cash entered by the user, and the changeValue variable represents the
  /// calculated change.
  final TextEditingController _cashController = TextEditingController();
  double cashValue = 0.0;
  double changeValue = 0.0;

  @override
  void initState() {
    _cashController.addListener(() {
      calculateChange();
    });
    super.initState();
  }

  ///The dispose method is overridden to dispose of the _cashController when the
  ///state is disposed. This is important to avoid memory leaks.
  @override
  void dispose() {
    _cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 340.0, right: 340, top: 290, bottom: 250),
        child: Center(
          child: Container(
            width: 1400,
            height: 750,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 75.0, right: 75),

              ///The dialog layout is divided into two parts using a Row
              child: Row(
                children: [
                  ///The left part contains information about the table and the total amount to be paid
                  Container(
                    width: 600,
                    height: 800,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 105,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'MESA ${widget.table.id}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 55,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 120,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBDEEDC),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'TOTAL',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  '${widget.table.getTotalAmount().toStringAsFixed(2)}€',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 120,
                          decoration: const BoxDecoration(
                            color: Color(0xFF5DDAAD),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Stack(
                              children: [
                                const Positioned(
                                  right: 372,
                                  top: 35,
                                  bottom: 0,
                                  child: Text(
                                    'INGRESO',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextField(
                                    controller: _cashController,
                                    readOnly: true,
                                    onChanged: (_) => calculateChange(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: '00.00€',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 120,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDA71FF),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'CAMBIO',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${(cashValue == 0 ? 0.0 : cashValue - widget.table.getTotalAmount()).toStringAsFixed(2)}€',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFE1B8),
                                minimumSize: const Size(290, 100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'CANCELAR',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () {
                                if ((cashValue -
                                        widget.table.getTotalAmount()) >=
                                    0) {
                                  widget.cobrarAction();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD056),
                                minimumSize: const Size(290, 100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'COBRAR',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),

                  /// The right part is a Numeric keypad
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Color del container
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Botonera(
                        pinController: _cashController,
                        goToMapaPage: (() {}),
                        text: '.',
                        w: 200,
                        h: 150,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// This method is called whenever the cash input changes. It updates the cashValue
  /// by parsing the text from the _cashController. If the parsing fails, it sets
  /// the cashValue to 0.0.
  void calculateChange() {
    setState(() {
      cashValue = double.tryParse(_cashController.text) ?? 0.0;
    });
  }
}
