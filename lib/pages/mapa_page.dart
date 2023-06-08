import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurante/dialogs/deleteDialog.dart';
import 'package:restaurante/pages/order_page.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../dialogs/warningDialog.dart';
import '../dialogs/moveDialog.dart';
import '../dialogs/paymentDialong.dart';
import '../models/firebase/customTable.dart';
import '../models/firebase/employe.dart';

class MapaPage extends StatefulWidget {
  final void Function(CustomTable) goToOrdersPage;

  const MapaPage({
    Key? key,
    required this.goToOrdersPage,
  }) : super(key: key);
  @override
  MapaPageState createState() => MapaPageState();
}

class MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    super.initState();
    reload();
  }

  Timer? timer;
  var textBottonSelec = 'SELECCIONAR';
  var textBottonMove = 'MOVER';
  bool canSelectTable = false;
  bool canMoveTable = false;
  final List<CustomTable> selectedTablesList = [];
  List<CustomTable> billedOutTableList = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  late CustomTable selectedTable;

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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 1670,
                    height: 1434,
                    decoration: const BoxDecoration(
                      color: Colors.white, // Color del container
                      boxShadow: [],
                    ),
                    child: Stack(children: [
                      Positioned.fill(
                        child: Opacity(
                          opacity: 1,
                          child: Image.asset(
                            'lib/assets/images/mapa_mesas_sin2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      buildMesas(),
                      //  buildTerraza(),
                    ]),
                  ),
                ),
                Container(
                  width: 333,
                  height: 1434,
                  decoration: const BoxDecoration(
                    color: Colors.white, // Color del container
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF3D8BE7)),
                          ),
                          onPressed: () {
                            resetBotonSelect();
                            setState(() {});
                          },
                          child: SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                textBottonSelec,
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFB0D5FF)),
                          ),
                          onPressed: () {
                            if (selectedTablesList.isNotEmpty) {
                              billedOutTableList = selectedTablesList
                                  .where((t) => t.orders.isNotEmpty)
                                  .toList();
                              setState(() {
                                resetBotonSelect();
                              });
                            } else {
                              showWarningDialog();
                            }
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                'IMPR CUENTA',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF3D8BE7)),
                          ),
                          onPressed: () async {
                            if (selectedTablesList.isNotEmpty) {
                              await showDialog(
                                  context: context,
                                  builder: (context) => DeleteDialog(
                                        closeAction: () =>
                                            Navigator.pop(context),
                                        buttonAction: () async {
                                          for (var t in selectedTablesList) {
                                            deleteTable(t.firebaseId);
                                            billedOutTableList.removeWhere(
                                                (nt) => nt.id == t.id);
                                          }
                                        },
                                        texto1:
                                            'SIEMPRE DE LAS GRACIAS A NUESTROS CLIENTES...',
                                        texto2: 'SI DEJAN PROPINA',
                                        texto3:
                                            'Asegúrese de que se han ido para blasfemar',
                                      ));
                              setState(() {
                                resetBotonSelect();
                              });
                            } else {
                              showWarningDialog();
                            }
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                'ELIMINAR',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFB0D5FF)),
                          ),
                          onPressed: () async {
                            if (selectedTablesList.isNotEmpty &&
                                selectedTablesList
                                    .any((nt) => nt.orders.isNotEmpty)) {
                              List<CustomTable> toGetPaymentTableList =
                                  selectedTablesList
                                      .where((nt) => nt.orders.isNotEmpty)
                                      .toList();

                              for (var t in toGetPaymentTableList) {
                                await showDialog(
                                    context: context,
                                    builder: (context) => PaymentDialog(
                                          cardAction: () {
                                            deleteTable(t.firebaseId);

                                            toGetPaymentTableList.clear();
                                            Navigator.pop(context);
                                          },
                                          table: t,
                                        ));
                              }

                              setState(() {
                                resetBotonSelect();
                              });
                            } else {
                              showWarningDialog();
                            }
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                'COBRAR',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF3D8BE7)),
                          ),
                          onPressed: () async {
                            if (canSelectTable &&
                                selectedTablesList.isNotEmpty &&
                                selectedTablesList
                                    .any((t) => t.orders.isNotEmpty)) {
                              resetBotonMove();
                              setState(() {});
                            } else {
                              resetBotonSelect();
                              showWarningDialog();
                            }
                          },
                          child: SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                textBottonMove,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFB0D5FF)),
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                'MENU',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF3D8BE7)),
                          ),
                          onPressed: () {
                            resetBotonSelect();
                            setState(() {});
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 190,
                            child: Align(
                              child: Text(
                                'EMPLEADOS',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMesas() {
    return Stack(
      children: [
        //PRIMERA FILA
        Positioned(
          top: 70,
          left: 50,
          child: buildMesaSigle(5),
        ),
        Positioned(
          top: 70,
          left: 300,
          child: buildMesaSigle(6),
        ),
        Positioned(
          top: 70,
          left: 550,
          child: buildMesaSigle(7),
        ),

        //SEGUNDA FILA
        Positioned(
          top: 320,
          left: 50,
          child: buildMesaSigle(8),
        ),
        Positioned(
          top: 320,
          left: 300,
          child: buildMesaSigle(9),
        ),
        Positioned(
          top: 320,
          left: 550,
          child: buildMesaSigle(10),
        ),

        //TERCERA FILA
        Positioned(
          top: 570,
          left: 50,
          child: buildMesaDoble(11),
        ),
        Positioned(
          top: 570,
          left: 475,
          child: buildMesaSigle(12),
        ),

        //CUARTA FILA
        Positioned(
          top: 820,
          left: 50,
          child: buildMesaDoble(13),
        ),
        Positioned(
          top: 820,
          left: 475,
          child: buildMesaSigle(14),
        ),

        //QUINTA FILA
        Positioned(
          top: 1070,
          left: 50,
          child: buildMesaDoble(15),
        ),
        Positioned(
          top: 1070,
          left: 475,
          child: buildMesaSigle(16),
        ),

        //BANQUETAS
        Positioned(
          top: 650,
          left: 825,
          child: buildMesaBanqueta(1),
        ),
        Positioned(
          top: 800,
          left: 825,
          child: buildMesaBanqueta(2),
        ),
        Positioned(
          top: 950,
          left: 825,
          child: buildMesaBanqueta(3),
        ),
        Positioned(
          top: 1100,
          left: 825,
          child: buildMesaBanqueta(4),
        ),

        // ----------- TERRAZA --------------
        //PRIMERA FILA
        Positioned(
          top: 70,
          left: 1200,
          child: buildMesaSigle(17),
        ),
        Positioned(
          top: 70,
          left: 1450,
          child: buildMesaSigle(22),
        ),

        //SEGUNDA FILA
        Positioned(
          top: 320,
          left: 1200,
          child: buildMesaSigle(18),
        ),
        Positioned(
          top: 320,
          left: 1450,
          child: buildMesaSigle(23),
        ),

        //TERCERA FILA
        Positioned(
          top: 570,
          left: 1200,
          child: buildMesaSigle(19),
        ),
        Positioned(
          top: 570,
          left: 1450,
          child: buildMesaSigle(24),
        ),

        //CUARTA FILA
        Positioned(
          top: 820,
          left: 1200,
          child: buildMesaSigle(20),
        ),
        Positioned(
          top: 820,
          left: 1450,
          child: buildMesaSigle(25),
        ),

        //QUINTA FILA
        Positioned(
          top: 1070,
          left: 1200,
          child: buildMesaSigle(21),
        ),
        Positioned(
          top: 1070,
          left: 1450,
          child: buildMesaSigle(26),
        ),
      ],
    );
  }

  Widget buildMesaSigle(int number) {
    Color colorMesa = const Color(0xFF5DDAAD);
    CustomTable? table;

    return FutureBuilder<CustomTable?>(
      future: getTableById(number),
      builder: (context, snapshot) {
        double topPosition = 40.0;
        double leftPosition = 45.0;

        if (snapshot.hasData && snapshot.data != null) {
          table = snapshot.data;

          if (isSelected(table!)) {
            colorMesa = const Color(0xFF8400B3);
          } else {
            if (isBilledOut(table!)) {
              colorMesa = const Color(0xFFFFD056);
            } else if (isBusy(table!)) {
              colorMesa = const Color(0xFFEC5D5D);
            } else if (isFree(table!)) {
              colorMesa = const Color(0xFF5DDAAD);
            }
          }
        } else {
          table = null;
        }

        if (number > 9) {
          leftPosition = 35.0;
        }

        return GestureDetector(
          onTap: () {
            setState(() {});
            if (canMoveTable && canSelectTable) {
              String opcionalText = '';
              if (table!.orders.isNotEmpty) {
                opcionalText =
                    'RECUERDE!\n LA MESA SELECCIONADA NO SE ENCUENTRA';
              } else {
                opcionalText = "HACIA MESA:\n ${table!.id}";
              }
              showDialog(
                  context: context,
                  builder: (context) => MoveDialog(
                        yesAction: () {
                          moveTable(selectedTablesList, table!);
                          Navigator.pop(context);
                          resetBotonSelect();
                          resetBotonMove();
                        },
                        noAction: () {
                          Navigator.pop(context);
                          resetBotonSelect();
                          resetBotonMove();
                        },
                        textoAUX: opcionalText,
                        texto1: 'MESA(S) SELECCIONADAS:\n'
                            ' ${obtainTablesNumber()}',
                      ));
            } else if (canSelectTable) {
              if (selectedTablesList.any((t) => t.id == table!.id)) {
                selectedTablesList.removeWhere((t) => t.id == table!.id);
                colorMesa = const Color(0xFF5DDAAD);
              } else {
                selectedTablesList.add(table!);
                print(selectedTablesList);
              }
            } else {
              timer!.cancel();
              widget.goToOrdersPage(table!);
            }
          },
          child: Container(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                Container(
                  color: colorMesa,
                ),
                Positioned(
                  top: topPosition,
                  left: leftPosition,
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMesaDoble(int number) {
    Color colorMesa = const Color(0xFF5DDAAD);
    CustomTable? table;
    return FutureBuilder<CustomTable?>(
      future: getTableById(number),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          table = snapshot.data;

          if (isSelected(table!)) {
            colorMesa = const Color(0xFF8400B3);
          } else {
            if (isBilledOut(table!)) {
              colorMesa = const Color(0xFFFFD056);
            } else if (isBusy(table!)) {
              colorMesa = const Color(0xFFEC5D5D);
            } else if (isFree(table!)) {
              colorMesa = const Color(0xFF5DDAAD);
            }
          }
        } else {
          table = null;
        }

        return InkWell(
          onTap: () {
            setState(() {});
            if (canMoveTable && canSelectTable) {
              String opcionalText = '';
              if (table!.orders.isNotEmpty) {
                opcionalText =
                    'RECUERDE!\n LA MESA SELECCIONADA NO SE ENCUENTRA';
              } else {
                opcionalText = "HACIA MESA:\n ${table!.id}";
              }
              showDialog(
                  context: context,
                  builder: (context) => MoveDialog(
                        yesAction: () {
                          moveTable(selectedTablesList, table!);
                          Navigator.pop(context);
                          resetBotonSelect();
                          resetBotonMove();
                        },
                        noAction: () {
                          Navigator.pop(context);
                          resetBotonSelect();
                          resetBotonMove();
                        },
                        textoAUX: opcionalText,
                        texto1: 'MESA(S) SELECCIONADAS:\n'
                            ' ${obtainTablesNumber()}',
                      ));
            } else if (canSelectTable) {
              if (selectedTablesList.any((t) => t.id == table!.id)) {
                selectedTablesList.removeWhere((t) => t.id == table!.id);
              } else {
                selectedTablesList.add(table!);
              }
            } else {
              timer!.cancel();
              widget.goToOrdersPage(table!);
            }
          },
          onLongPress: () {
            setState(() {
              colorMesa == const Color.fromRGBO(58, 0, 138, 1);
            });
          },
          child: Container(
            width: 300,
            height: 120,
            color: colorMesa,
            child: Stack(
              children: [
                Positioned(
                  top: 35.0,
                  left: 120.0,
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMesaBanqueta(int number) {
    Color colorMesa = const Color(0xFF5DDAAD);
    CustomTable? table;
    return FutureBuilder<CustomTable?>(
      future: getTableById(number),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          table = snapshot.data;

          if (isSelected(table!)) {
            colorMesa = const Color(0xFF8400B3);
          } else {
            if (isBilledOut(table!)) {
              colorMesa = const Color(0xFFFFD056);
            } else if (isBusy(table!)) {
              colorMesa = const Color(0xFFEC5D5D);
            } else if (isFree(table!)) {
              colorMesa = const Color(0xFF5DDAAD);
            }
          }
        } else {
          table = null;
        }
        return GestureDetector(
          onTap: () {
            setState(() {});
            if (canMoveTable && canSelectTable) {
              String opcionalText = '';
              if (table!.orders.isNotEmpty) {
                opcionalText =
                    'RECUERDE!\n LA MESA SELECCIONADA NO SE ENCUENTRA';
              } else {
                opcionalText = "HACIA MESA:\n ${table!.id}";
              }
              showDialog(
                  context: context,
                  builder: (context) => MoveDialog(
                        yesAction: () {
                          moveTable(selectedTablesList, table!);
                          Navigator.pop(context);
                          resetBotonSelect();
                          resetBotonMove();
                        },
                        noAction: () {
                          Navigator.pop(context);
                          resetBotonSelect();
                          resetBotonMove();
                        },
                        textoAUX: opcionalText,
                        texto1: 'MESA(S) SELECCIONADAS:\n'
                            ' ${obtainTablesNumber()}',
                      ));
            } else if (canSelectTable) {
              if (selectedTablesList.any((t) => t.id == table!.id)) {
                selectedTablesList.removeWhere((t) => t.id == table!.id);
                colorMesa = const Color(0xFF5DDAAD);
              } else {
                selectedTablesList.add(table!);
              }
            } else {
              timer!.cancel();
              widget.goToOrdersPage(table!);
            }

            // Acción al hacer clic en la mesa
          },
          onLongPress: () {
            setState(() {});
          },
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: colorMesa,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isBusy(CustomTable t) {
    if (t.orders.isNotEmpty &&
        !selectedTablesList.any((nt) => nt.id == t.id) &&
        !billedOutTableList.any((nt) => nt.id == t.id)) {
      return true;
    } else {
      return false;
    }
  }

  bool isFree(CustomTable t) {
    if (!billedOutTableList.any((nt) =>
        nt.id == t.id &&
        !t.orders.isNotEmpty &&
        !selectedTablesList.any((nt) => nt.id == t.id))) {
      return true;
    } else {
      return false;
    }
  }

  bool isBilledOut(CustomTable t) {
    if (t.orders.isNotEmpty &&
        billedOutTableList.any((nt) => nt.id == t.id) &&
        !selectedTablesList.any((nt) => nt.id == t.id)) {
      return true;
    } else {
      return false;
    }
  }

  bool isSelected(CustomTable t) {
    if (selectedTablesList.any((nt) => nt.id == t.id)) {
      return true;
    } else {
      return false;
    }
  }

  void resetBotonSelect() {
    if (textBottonSelec == 'SELECCIONAR') {
      textBottonSelec = 'DESELECCIONAR';
      canSelectTable = !canSelectTable;
    } else {
      textBottonSelec = 'SELECCIONAR';
      canSelectTable = !canSelectTable;
      selectedTablesList.clear();
    }
  }

  void resetBotonMove() {
    if (textBottonMove == 'MOVER') {
      textBottonMove = 'NO MOVER';
      canMoveTable = !canMoveTable;
    } else {
      textBottonMove = 'MOVER';
      canMoveTable = !canMoveTable;
    }
  }

  void reload() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        buildMesas();
      });
    });
  }

  String obtainTablesNumber() {
    String tablesNumber = "";
    for (var t in selectedTablesList) {
      tablesNumber += " ${t.id} ";
    }
    return tablesNumber;
  }

  Future<void> showWarningDialog() async {
    await showDialog(
        context: context,
        builder: (context) => WarningDialog(
              closeAction: () {
                Navigator.pop(context);
              },
              texto1: "CUIDADO JEFE,\n NO HA SELECCIONADO NINGUNA MESA",
            ));
  }
}
