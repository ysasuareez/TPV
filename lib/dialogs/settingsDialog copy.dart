import 'package:flutter/material.dart';

/// Represents a dialog for settings.
class SettingsDialog extends StatefulWidget {
  ///It contains the following properties:
  ///goToLoginPage: A callback function that will be invoked when the
  ///"Cerrar Sesión" (Logout) button is pressed.
  final void Function() goToLoginPage;

  ///goToBBDDPage: A callback function that will be invoked when the
  ///"BBDD MESAS" (BBDDPage class) button is pressed.
  final void Function() goToBBDDPage;

  ///goToEmployeesPage: A callback function that will be invoked when the
  ///"EMPLEADOS" (EmployeesPage) button is pressed.
  final void Function() goToEmployeesPage;

  const SettingsDialog({
    Key? key,
    required this.goToLoginPage,
    required this.goToBBDDPage,
    required this.goToEmployeesPage,
  }) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 1050,
          right: 400,
          top: 600,
          bottom: 100,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
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
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 39, 66, 91),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SETTINGS',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.goToEmployeesPage();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF3D8BE7),
                        minimumSize: const Size(double.infinity, 100),
                      ),
                      child: const Text(
                        'EMPLEADOS',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.goToBBDDPage();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF3D8BE7),
                        minimumSize: const Size(double.infinity, 100),
                      ),
                      child: const Text(
                        'BBDD MESAS',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: widget.goToLoginPage,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFEC5D5D),
                        minimumSize: const Size(double.infinity, 100),
                      ),
                      child: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
