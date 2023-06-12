import 'package:flutter/material.dart';
import 'package:restaurante/models/customTable.dart';

import '../services/firebase_service.dart';

/// Represents a page that displays a CustomTable list from a database and allows the user
/// to interact with it through a dropdown menu. The data is fetched
/// asynchronously, and the displayed tables can be sorted based on different
/// criteria.
/// It simulates a table-like layout to display tables data. The UI is designed
/// using a combination of Flutter widgets to create the appearance of a table.
class BBDDPage extends StatefulWidget {
  /// It contains the following properties:
  /// goToMapaPage: A callback function that will be invoked when the
  /// "VOLVER" button is pressed.
  final void Function() goToMapaPage;

  const BBDDPage({
    super.key,
    required this.goToMapaPage,
  });

  @override
  BBDDPageState createState() => BBDDPageState();
}

class BBDDPageState extends State<BBDDPage> {
  /// dropdownValue (String): Stores the selected value in the DropdownButton to
  /// sort the tables list.
  String dropdownValue = 'Recientes';

  /// bbddTablesList (List<CustomTable>): Stores the list of employees obtained
  /// from the data source.
  List<CustomTable> bbddTablesList = [];

  /// isDataLoaded (bool): Indicates whether the data has been successfully loaded.
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// It initializes the state and loads the data.
    _loadData();
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
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.only(left: 150, right: 150.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// To come back to MapaPage
                      ElevatedButton(
                        onPressed: () {
                          widget.goToMapaPage();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 39, 66, 91),
                        ),
                        child: const SizedBox(
                          width: 200,
                          height: 80,
                          child: Center(
                            child: Text(
                              'VOLVER',
                              style: TextStyle(
                                fontSize:
                                    30, // Ajusta el tamaño de la fuente del texto
                                color: Colors
                                    .white, // Establece el color del texto
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// It's a dropdown button that allows the user to select
                      /// an option to sort the tables list. The selected
                      /// value is updated in dropdownValue using setState() to
                      /// reflect the changes in the UI.
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 400,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black),
                              underline: Container(),
                              itemHeight: 80,
                              dropdownColor: Colors.white,
                              items: <String>[
                                'Recientes',
                                'Más antiguos',
                                'Mayor precio',
                                'Menor precio',
                                'Eliminadas',
                                'Cobradas',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 300,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 1800,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white, // Color del container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 150,
                        child: Center(
                          child: Text("Nº", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 255, 148, 148),
                        width: 330,
                        child: const Center(
                          child: Text("FECHA", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 134, 190, 255),
                        width: 330,
                        child: const Center(
                          child:
                              Text("APERTURA", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 248, 220, 151),
                        width: 330,
                        child: const Center(
                          child: Text("CIERRE", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 152, 225, 198),
                        width: 330,
                        child: const Center(
                          child: Text("ESTADO", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 227, 187, 241),
                        width: 320,
                        child: const Center(
                          child:
                              Text("IMPORTE", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 1800,
                  height: 1125,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),

                  /// The usage of FutureBuilder: The widget uses a FutureBuilder
                  /// to asynchronously load and display the data from the database.
                  /// It shows a loading indicator while the data is being fetched
                  /// and handles different states (waiting, error, and data available).
                  child: FutureBuilder<List<CustomTable>>(
                    future: getBBDDTables(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        bbddTablesList = snapshot.data!;
                        List<CustomTable> sortedTables = getSortedTables();
                        return ListView.builder(
                          itemCount: sortedTables.length,
                          itemBuilder: (context, index) {
                            CustomTable t = sortedTables[index];
                            return Container(
                              width: 1800,
                              height: 80,
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 166, 166, 166)),
                              )),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255,
                                          255), // Color del container
                                    ),
                                    width: 150,
                                    child: Center(
                                      child: Text('${t.id}',
                                          style: const TextStyle(fontSize: 35)),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 255, 230, 230),
                                    width: 330,
                                    child: Center(
                                      child: Text(t.date,
                                          style: const TextStyle(fontSize: 30)),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 230, 241, 255),
                                    width: 330,
                                    child: Center(
                                      child: Text(t.openingTime,
                                          style: const TextStyle(fontSize: 30)),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 255, 243, 211),
                                    width: 330,
                                    child: Center(
                                      child: Text(t.closingTime,
                                          style: const TextStyle(fontSize: 30)),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 227, 255, 245),
                                    width: 330,
                                    child: Center(
                                      child: Text(t.state,
                                          style: const TextStyle(fontSize: 30)),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 251, 239, 255),
                                    width: 320,
                                    child: Center(
                                      child: Text('${t.getTotalAmount()}',
                                          style: const TextStyle(fontSize: 30)),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No tables found.'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// An asynchronous method that loads data from the database. It updates the
  /// state with the loaded data.
  Future<void> _loadData() async {
    try {
      List<CustomTable> tables = await getBBDDTables();
      setState(() {
        bbddTablesList = tables;
        isDataLoaded = true;
      });
    } catch (error) {}
  }

  /// A method that returns a sorted list of CustomTable objects based on the
  /// selected dropdown value. It sorts the bbddTablesList based on the selected
  /// dropdown value.
  List<CustomTable> getSortedTables() {
    List<CustomTable> sortedTables = List.from(bbddTablesList);

    switch (dropdownValue) {
      case 'Recientes':
        sortedTables.sort((a, b) => b.openingTime.compareTo(a.openingTime));
        break;
      case 'Más antiguos':
        sortedTables.sort((a, b) => a.openingTime.compareTo(b.openingTime));
        break;
      case 'Mayor precio':
        sortedTables
            .sort((a, b) => b.getTotalAmount().compareTo(a.getTotalAmount()));
        break;
      case 'Menor precio':
        sortedTables
            .sort((a, b) => a.getTotalAmount().compareTo(b.getTotalAmount()));
        break;
      case 'Eliminadas':
        sortedTables =
            sortedTables.where((table) => table.state == 'eliminada').toList();
        break;
      case 'Cobradas':
        sortedTables =
            sortedTables.where((table) => table.state == 'cobrada').toList();
        break;
    }

    return sortedTables;
  }
}
