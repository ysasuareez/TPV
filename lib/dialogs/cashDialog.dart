import 'package:flutter/material.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../models/firebase/customTable.dart';

class CashDialog extends StatefulWidget {
  final CustomTable table;

  const CashDialog({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  State<CashDialog> createState() => _CashPaymentDialogState();
}

class _CashPaymentDialogState extends State<CashDialog> {
  final TextEditingController _cashController = TextEditingController();
  double cashValue = 0.0;
  double changeValue = 0.0;

  void calculateChange() {
    setState(() {
      cashValue = double.tryParse(_cashController.text) ?? 0.0;
    });
  }

  @override
  void initState() {
    _cashController.addListener(() {
      calculateChange();
    });
    super.initState();
  }

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
              child: Row(
                children: [
                  Container(
                    width: 600,
                    height: 800,
                    decoration: BoxDecoration(
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
                          decoration: BoxDecoration(
                            color: const Color(0xFFBDEEDC),
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
                                  style: TextStyle(
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
                          decoration: BoxDecoration(
                            color: const Color(0xFF5DDAAD),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Stack(
                              children: [
                                Positioned(
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
                                    style: TextStyle(
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
                          decoration: BoxDecoration(
                            color: const Color(0xFFDA71FF),
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
                                  style: TextStyle(
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
                                backgroundColor: Color(0xFFFFE1B8),
                                minimumSize: Size(290, 100),
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
                                  deleteTable(widget.table.firebaseId);
                                  print(widget.table.firebaseId);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
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
                  SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
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
                              buildNumericButton('.', Color(0xFF3D8BE7)),
                            ],
                          ),
                          SizedBox(height: 2.0),
                        ],
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

  Widget buildNumericButton(String label, Color backgroundColor) {
    return Container(
      width: 200,
      height: 150,
      child: ElevatedButton(
        onPressed: () {
          _cashController.text += label;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 90,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(String label, IconData iconData) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (label == 'D' && _cashController.text.isNotEmpty) {
              _cashController.text = _cashController.text
                  .substring(0, _cashController.text.length - 1);
            } else if (label == 'S') {
              //CALCULAR VUELTA
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
