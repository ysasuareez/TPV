import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/firebase_service.dart';
import '../firebase/item.dart';
import 'group.dart';
import '../firebase/customTable.dart';

class Bill extends StatefulWidget {
  final CustomTable table;
  final List<Item> orderList;
  final Function() reload;

  const Bill(
      {super.key,
      required this.table,
      required this.orderList,
      required this.reload});

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  @override
  void initState() {
    super.initState();
  }

  Timer? timer;

  double totalPrice = 0;
  List<Group> groupList = [];

  @override
  Widget build(BuildContext context) {
    groupList = _getGroupedOrder();
    totalPrice = widget.orderList
        .map((e) => e.price)
        .fold(0, (value, element) => value + element);

    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        children: [
          Container(
            width: 870,
            height: 78.01,
            color: const Color(0xFF3D8BE7),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 8),
              child: Text("MESA ${widget.table.id}",
                  style: const TextStyle(fontSize: 40, color: Colors.white)),
            ),
          ),
          Container(
            width: 870,
            height: 50,
            decoration: const BoxDecoration(
                color: Color(0xFFB0D5FF),
                border: Border(
                  left: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                  right: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                  bottom: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                )),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 360,
                    child: Text("PRODUCTO", style: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  width: 1.5,
                  color: const Color.fromARGB(255, 166, 166, 166),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 60,
                    child: Text("UDS.", style: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  width: 1.5,
                  color: const Color.fromARGB(255, 166, 166, 166),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: Text("IMPORTE", style: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  width: 1.5,
                  color: const Color.fromARGB(255, 166, 166, 166),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: Text("TOTAL", style: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  width: 1.5,
                  color: const Color.fromARGB(255, 166, 166, 166),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: 870,
              height: 565.51,
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                      right: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                      bottom:
                          BorderSide(color: Color(0xFF3D8BE7), width: 2.0))),
              child: ListView(
                shrinkWrap: true,
                children: groupList.map((item) {
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 166, 166, 166)),
                    )),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 11, bottom: 8),
                          child: SizedBox(
                            width: 360,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(item.name,
                                      style: const TextStyle(fontSize: 30)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1.5,
                          height: 77,
                          color: const Color.fromARGB(255, 166, 166, 166),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 60,
                            child: Text("${item.units}",
                                style: const TextStyle(fontSize: 30)),
                          ),
                        ),
                        Container(
                          height: 77,
                          width: 1.5,
                          color: const Color.fromARGB(255, 166, 166, 166),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            child: Text("${item.price}€",
                                style: const TextStyle(fontSize: 30)),
                          ),
                        ),
                        Container(
                          height: 77,
                          width: 1.5,
                          color: const Color.fromARGB(255, 166, 166, 166),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            child: Text("${item.totalPirce}€",
                                style: const TextStyle(fontSize: 30)),
                          ),
                        ),
                        Container(
                          height: 77,
                          width: 1.5,
                          color: const Color.fromARGB(255, 166, 166, 166),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                          child: IconButton(
                            onPressed: () async {
                              await deleteItemFromTable(
                                  widget.table.firebaseId, item.name);
                              widget.reload();
                            },
                            icon: const Icon(Icons.close),
                            iconSize: 40,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 107,
            width: 870,
            decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                    right: BorderSide(color: Color(0xFF3D8BE7), width: 2.0),
                    bottom: BorderSide(color: Color(0xFF3D8BE7), width: 2.0))),
            child: Row(
              children: [
                Container(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "UDS.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 595,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.orderList.length}",
                      style: const TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1.5,
                  color: const Color(0xFF3D8BE7),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "TOTAL",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$totalPrice",
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Group> _getGroupedOrder() {
    Map<String, Group> orderGroup = {};

    for (var item in widget.orderList) {
      String key = item.name;
      if (orderGroup.containsKey(key)) {
        orderGroup[key]!.units += 1;
      } else {
        orderGroup[key] = Group(
          id: item.id,
          name: item.name,
          price: item.price,
          units: 1,
        );
      }
    }

    return orderGroup.values.toList();
  }
}
