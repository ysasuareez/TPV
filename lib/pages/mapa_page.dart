import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurante/dialogs/byeDialog.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../dialogs/cashDialog.dart';
import '../dialogs/deleteDialog.dart';
import '../dialogs/settingsDialog copy.dart';
import '../dialogs/warningDialog.dart';
import '../dialogs/moveDialog.dart';
import '../dialogs/paymentDialong.dart';
import '../models/customTable.dart';

/// Represents a Flutter page called "MapaPage", which displays a map of tables
/// in a restaurant.
class MapaPage extends StatefulWidget {
  /// It contains the following properties:
  /// A function that navigates to the order page.
  final void Function(CustomTable) goToOrderPage;

  ///  A function that navigates to the login page.
  final void Function() goToLoginPage;

  ///  A function that navigates to the database page.
  final void Function() goToBBDDPage;

  /// A function that navigates to the employees page.
  final void Function() goToEmployeesPage;

  const MapaPage({
    Key? key,
    required this.goToOrderPage,
    required this.goToLoginPage,
    required this.goToBBDDPage,
    required this.goToEmployeesPage,
  }) : super(key: key);
  @override
  MapaPageState createState() => MapaPageState();
}

class MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    super.initState();
  }

  /// A Timer object used for scheduling a periodic callback
  Timer? timer;

  /// A string variable representing the text to display on a button for
  ///selecting tables.
  var textBottonSelec = 'SELECCIONAR';

  /// A string variable representing the text to display on a button for
  ///moving tables.
  var textBottonMove = 'MOVER';

  /// A boolean variable indicating whether tables can be selected.
  bool canSelectTable = false;

  /// A boolean variable indicating whether tables can be moved.
  bool canMoveTable = false;

  /// A list of CustomTable objects representing the selected tables.
  final List<CustomTable> selectedTablesList = [];

  /// A list of CustomTable objects representing the tables with billed orders.
  List<CustomTable> billedOutTableList = [];

  /// A list of CustomTable objects representing the tables for which payment is due.
  List<CustomTable> toGetPaymentTableList = [];

  @override
  Widget build(BuildContext context) {
    reload();
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
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15, left: 40, right: 15),
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
                      buildPositionTables(),
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
                                const Color.fromARGB(255, 201, 106, 235)),
                          ),
                          onPressed: () {
                            resetBotonSelect();
                            setState(() {});
                          },
                          child: SizedBox(
                            width: 290,
                            height: 225,
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
                              for (var t in billedOutTableList) {
                                updateIsBilledOut(t, 'true');
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
                            height: 225,
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
                              showDialog(
                                  context: context,
                                  builder: (context) => DeleteDialog(
                                        afirmativeAction: () async {
                                          for (var t in selectedTablesList) {
                                            await updateTable(t, 'eliminada');

                                            billedOutTableList.removeWhere(
                                                (nt) => nt.id == t.id);

                                            await closeTable(
                                              t,
                                            );
                                          }
                                          setState(() {
                                            Navigator.pop(context);
                                            resetBotonSelect();
                                          });
                                        },
                                      ));
                            } else {
                              showWarningDialog();
                            }
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 225,
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
                              toGetPaymentTableList = selectedTablesList
                                  .where((nt) => nt.orders.isNotEmpty)
                                  .toList();

                              await showPaymentDialogs(
                                  toGetPaymentTableList, 0);

                              setState(() {
                                resetBotonSelect();
                              });
                            } else {
                              showWarningDialog();
                            }
                          },
                          child: const SizedBox(
                            width: 290,
                            height: 225,
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
                            height: 225,
                            child: Align(
                              child: Text(
                                textBottonMove,
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
                                const Color.fromARGB(255, 39, 66, 91)),
                          ),
                          onPressed: () {
                            if (!canMoveTable && !canSelectTable) {
                              showDialog(
                                  context: context,
                                  builder: (context) => SettingsDialog(
                                        goToLoginPage: () async {
                                          Navigator.pop(context);
                                          timer!.cancel();
                                          widget.goToLoginPage();
                                        },
                                        goToBBDDPage: () async {
                                          Navigator.pop(context);
                                          timer!.cancel();
                                          widget.goToBBDDPage();
                                        },
                                        goToEmployeesPage: () async {
                                          Navigator.pop(context);
                                          timer!.cancel();
                                          widget.goToEmployeesPage();
                                        },
                                      ));
                            }
                          },
                          child: SizedBox(
                            width: 290,
                            height: 225,
                            child: Align(
                              child: Image.asset(
                                'lib/assets/images/settings.png',
                                height: 170,
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

  ///This method is responsible for displaying payment dialogs the user.
  Future<void> showPaymentDialogs(
      List<CustomTable> tableList, int currentIndex) async {
    if (currentIndex >= tableList.length) {
      showDialog(
        context: context,
        builder: (context) => const ByeDialog(),
      );
      toGetPaymentTableList.clear();
      return;
    }

    var t = tableList[currentIndex];
    await showDialog(
      context: context,
      builder: (context) => PaymentDialog(
        table: t,
        cardAction: () async {
          await updateTable(t, 'cobrada');

          setState(() {
            Navigator.pop(context);
          });
          await closeTable(
            t,
          );
          await showPaymentDialogs(tableList, currentIndex + 1);
        },
        cashAction: () async {
          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (BuildContext context) => CashDialog(
              table: t,
              cobrarAction: () async {
                await updateTable(t, 'cobrada');

                setState(() {
                  Navigator.pop(context);
                });
                await closeTable(
                  t,
                );
                await showPaymentDialogs(tableList, currentIndex + 1);
              },
            ),
          );
        },
      ),
    );
  }

  /// A method that builds the table map UI.
  Widget buildPositionTables() {
    return Stack(
      children: [
        //PRIMERA FILA
        Positioned(
          top: 70,
          left: 50,
          child: buildSingleTable(5),
        ),
        Positioned(
          top: 70,
          left: 300,
          child: buildSingleTable(6),
        ),
        Positioned(
          top: 70,
          left: 550,
          child: buildSingleTable(7),
        ),

        //SEGUNDA FILA
        Positioned(
          top: 320,
          left: 50,
          child: buildSingleTable(8),
        ),
        Positioned(
          top: 320,
          left: 300,
          child: buildSingleTable(9),
        ),
        Positioned(
          top: 320,
          left: 550,
          child: buildSingleTable(10),
        ),

        //TERCERA FILA
        Positioned(
          top: 570,
          left: 50,
          child: buildDoubleTable(11),
        ),
        Positioned(
          top: 570,
          left: 475,
          child: buildSingleTable(12),
        ),

        //CUARTA FILA
        Positioned(
          top: 820,
          left: 50,
          child: buildDoubleTable(13),
        ),
        Positioned(
          top: 820,
          left: 475,
          child: buildSingleTable(14),
        ),

        //QUINTA FILA
        Positioned(
          top: 1070,
          left: 50,
          child: buildDoubleTable(15),
        ),
        Positioned(
          top: 1070,
          left: 475,
          child: buildSingleTable(16),
        ),

        //BANQUETAS
        Positioned(
          top: 650,
          left: 825,
          child: buildCircleChair(1),
        ),
        Positioned(
          top: 800,
          left: 825,
          child: buildCircleChair(2),
        ),
        Positioned(
          top: 950,
          left: 825,
          child: buildCircleChair(3),
        ),
        Positioned(
          top: 1100,
          left: 825,
          child: buildCircleChair(4),
        ),

        // ----------- TERRAZA --------------
        //PRIMERA FILA
        Positioned(
          top: 70,
          left: 1200,
          child: buildSingleTable(17),
        ),
        Positioned(
          top: 70,
          left: 1450,
          child: buildSingleTable(22),
        ),

        //SEGUNDA FILA
        Positioned(
          top: 320,
          left: 1200,
          child: buildSingleTable(18),
        ),
        Positioned(
          top: 320,
          left: 1450,
          child: buildSingleTable(23),
        ),

        //TERCERA FILA
        Positioned(
          top: 570,
          left: 1200,
          child: buildSingleTable(19),
        ),
        Positioned(
          top: 570,
          left: 1450,
          child: buildSingleTable(24),
        ),

        //CUARTA FILA
        Positioned(
          top: 820,
          left: 1200,
          child: buildSingleTable(20),
        ),
        Positioned(
          top: 820,
          left: 1450,
          child: buildSingleTable(25),
        ),

        //QUINTA FILA
        Positioned(
          top: 1070,
          left: 1200,
          child: buildSingleTable(21),
        ),
        Positioned(
          top: 1070,
          left: 1450,
          child: buildSingleTable(26),
        ),
      ],
    );
  }

  /// A method that builds a single table widget.
  Widget buildSingleTable(int number) {
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
              widget.goToOrderPage(table!);
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

  /// A method that builds a double table widget.
  Widget buildDoubleTable(int number) {
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
              widget.goToOrderPage(table!);
            }
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

  /// A method that builds a cirlce chair widget.
  Widget buildCircleChair(int number) {
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
              widget.goToOrderPage(table!);
            }
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

  /// This method checks if the specified table is currently busy.
  /// It examines the status field of the table object and returns true if the
  /// status is set to busy.
  bool isBusy(CustomTable t) {
    if (t.orders.isNotEmpty &&
        !selectedTablesList.any((nt) => nt.id == t.id) &&
        !billedOutTableList.any((nt) => nt.id == t.id)) {
      return true;
    } else {
      return false;
    }
  }

  /// This method checks if the specified table is currently available or free.
  ///  It examines the status field of the table object and returns true if the
  ///  status is set to "free", indicating that the table is available for use.
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

  /// This method checks if a specific CustomTable is billed out. It checks if
  /// the given table is present in the billedOutTableList, which contains
  /// tables that have been billed out.
  bool isBilledOut(CustomTable t) {
    if (t.orders.isNotEmpty &&
        t.isBilledOut == 'true' &&
        !selectedTablesList.any((nt) => nt.id == t.id)) {
      return true;
    } else {
      return false;
    }
  }

  /// This method checks if a specific CustomTable is selected. It iterates over
  /// the selectedTablesList and compares the IDs of the tables to determine if
  ///  the given table is selected.
  bool isSelected(CustomTable t) {
    if (selectedTablesList.any((nt) => nt.id == t.id)) {
      return true;
    } else {
      return false;
    }
  }

  /// This method resets the state and text of the "SELECCIONAR" button.
  /// It clears the selectedTablesList and sets the canSelectTable flag to false.
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

  /// This method resets the state and text of the "MOVER" button. It clears the
  /// selectedTablesList and sets the canMoveTable flag to false.
  void resetBotonMove() {
    if (textBottonMove == 'MOVER') {
      textBottonMove = 'NO MOVER';
      canMoveTable = !canMoveTable;
    } else {
      textBottonMove = 'MOVER';
      canMoveTable = !canMoveTable;
    }
  }

  /// This method reloads the state of the widget. It fetches the latest table
  /// data from the database and updates the UI accordingly.
  void reload() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        buildPositionTables();
      });
    });
  }

  /// This method returns the total number of tables in the map. It calculates
  /// the count by accessing the tablesList and counting the number of elements
  /// in the list.
  String obtainTablesNumber() {
    String tablesNumber = "";
    for (var t in selectedTablesList) {
      tablesNumber += " ${t.id} ";
    }
    return tablesNumber;
  }

  /// This method displays a warning dialog to the user when an action is
  /// performed without selecting any tables. It informs the user to select
  /// at least one table before proceeding.
  Future<void> showWarningDialog() async {
    await showDialog(
        context: context,
        builder: (context) => WarningDialog(
              closeAction: () {
                Navigator.pop(context);
              },
            ));
  }
}
