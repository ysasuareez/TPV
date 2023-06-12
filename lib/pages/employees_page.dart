import 'package:flutter/material.dart';
import 'package:restaurante/models/customTable.dart';

import '../models/employe.dart';
import '../services/firebase_service.dart';

/// Represents a page of Employee list that displays data from a database and
/// allows the user to interact with it through a dropdown menu. The data is
/// fetched asynchronously, and the displayed tables can be sorted based on ç
/// different criteria.
/// It simulates a table-like layout to display employee data. The UI is designed
/// using a combination of Flutter widgets to create the appearance of a table.
class EmployeesPage extends StatefulWidget {
  final void Function() goToMapaPage;

  const EmployeesPage({
    super.key,
    required this.goToMapaPage,
  });

  @override
  EmployeesPageState createState() => EmployeesPageState();
}

class EmployeesPageState extends State<EmployeesPage> {
  /// dropdownValue (String): Stores the selected value in the DropdownButton
  /// to sort the employees list.
  String dropdownValue = 'Recientes';

  /// employesList (List<Employee>): Stores the list of employees obtained
  /// from the data source.
  List<Employee> employesList = [];

  /// isDataLoaded (bool): Indicates whether the data has been successfully
  /// loaded.
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
                          backgroundColor: const Color.fromARGB(255, 39, 66, 91),
                        ),
                        child: const SizedBox(
                          width: 200,
                          height: 80,
                          child: Center(
                            child: Text(
                              'VOLVER',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// It's a dropdown button that allows the user to select
                      /// an option to sort the employees' list. The selected
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
                                'Nombre',
                                'Recientes',
                                'Más antiguos',
                                'Mayor salario',
                                'Menor salario',
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
                        width: 250,
                        child: Center(
                          child: Text("ID", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 255, 148, 148),
                        width: 350,
                        child: const Center(
                          child: Text("NOMBRE", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 134, 190, 255),
                        width: 300,
                        child: const Center(
                          child: Text("FECHA", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 248, 220, 151),
                        width: 300,
                        child: const Center(
                          child: Text("DNI", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 152, 225, 198),
                        width: 291,
                        child: const Center(
                          child: Text("PIN", style: TextStyle(fontSize: 35)),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        color: const Color.fromARGB(255, 166, 166, 166),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 227, 187, 241),
                        width: 300,
                        child: const Center(
                          child:
                              Text("SALARIO", style: TextStyle(fontSize: 35)),
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

                  /// It's used to handle the asynchronous loading of the
                  /// employee list. It shows different widgets based on the
                  /// connection state and whether there is data or an error.
                  /// When the data is available, a ListView.builder is used to
                  /// display the sorted list of employees based on the selected
                  /// value in dropdownValue.
                  child: FutureBuilder<List<Employee>>(
                    future: getEmployees(),
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
                        employesList = snapshot.data!;
                        List<Employee> sortedTables = getSortedTables();
                        return ListView.builder(
                          itemCount: sortedTables.length,
                          itemBuilder: (context, index) {
                            Employee t = sortedTables[index];
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
                                      color: Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                    width: 250,
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
                                    width: 350,
                                    child: Center(
                                      child: Text(t.name,
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
                                    width: 300,
                                    child: Center(
                                      child: Text(t.birthDate,
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
                                    width: 300,
                                    child: Center(
                                      child: Text(t.dni,
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
                                    width: 291,
                                    child: Center(
                                      child: Text((t.pin).toString(),
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
                                    width: 300,
                                    child: Center(
                                      child: Text(t.salary,
                                          style: const TextStyle(fontSize: 30)),
                                    ),
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

  /// An asynchronous method that loads the employee data from a data source.
  /// It updates the state of employesList and isDataLoaded.
  Future<void> _loadData() async {
    try {
      List<Employee> employees = await getEmployees();
      setState(() {
        employesList = employees;
        isDataLoaded = true;
      });
    } catch (error) {}
  }

  /// A method that returns the sorted list of employees based on the selected
  /// value in dropdownValue.
  List<Employee> getSortedTables() {
    List<Employee> sortedEmployee = List.from(employesList);

    switch (dropdownValue) {
      case 'Nombre':
        sortedEmployee.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Mayor salario':
        sortedEmployee.sort((a, b) => b.salary.compareTo(a.salary));
        break;
      case 'Menor salario':
        sortedEmployee.sort((a, b) => a.salary.compareTo(b.salary));
        break;
    }

    return sortedEmployee;
  }
}
