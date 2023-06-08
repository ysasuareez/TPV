import 'package:flutter/material.dart';
import 'package:restaurante/models/firebase/item.dart';
import 'package:restaurante/models/firebase/subcategory.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../dialogs/paymentDialong.dart';
import '../models/firebase/category.dart';
import '../models/firebase/customTable.dart';
import '../models/utils/group.dart';

class OrdersPage extends StatefulWidget {
  final void Function(CustomTable) goToOrderPage;
  final void Function() goToMapaPage;
  final CustomTable table;

  const OrdersPage(
      {super.key,
      required this.table,
      required this.goToMapaPage,
      required this.goToOrderPage});

  @override
  OrdersPageState createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage> {
  //DISEÑO MENU
  Color categoryColor = Color(0xFF5DDAAD);
  Color subcategoryColor = Color(0xFFFFD056);
  Color itemColor = Color(0xFFDA71FF);
  List<Category> categories = [];
  Category currentCategory = Category(id: "", name: "", subcategories: []);
  Subcategory currentSubcategory = Subcategory(id: "", name: "", items: []);
  List<Item> currentSubcategoryItemList = [];

  //DISEÑO OPCIONES
  double w = 255;
  double h = 230;

  //UTILS
  List<Group> groupList = [];
  double totalPrice = 0;
  List<Item> orderList = [];
  List<Item> newItemsList = [];

  @override
  void initState() {
    _loadDataMenu();
    _loadDataBill();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              //BILL
              Padding(
                padding: const EdgeInsets.only(left: 9, top: 12),
                child: Column(
                  children: [
                    Container(
                      width: 870,
                      height: 78.01,
                      color: const Color(0xFF3D8BE7),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 8),
                        child: Text("MESA ${widget.table.id}",
                            style: const TextStyle(
                                fontSize: 40, color: Colors.white)),
                      ),
                    ),
                    Container(
                      width: 870,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color(0xFFB0D5FF),
                          border: Border(
                            left: BorderSide(
                                color: Color(0xFF3D8BE7), width: 2.0),
                            right: BorderSide(
                                color: Color(0xFF3D8BE7), width: 2.0),
                            bottom: BorderSide(
                                color: Color(0xFF3D8BE7), width: 2.0),
                          )),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: SizedBox(
                              width: 360,
                              child: Text("PRODUCTO",
                                  style: TextStyle(fontSize: 30)),
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
                              child:
                                  Text("UDS.", style: TextStyle(fontSize: 30)),
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
                              child: Text("IMPORTE",
                                  style: TextStyle(fontSize: 30)),
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
                              child:
                                  Text("TOTAL", style: TextStyle(fontSize: 30)),
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
                        height: 655,
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Color(0xFF3D8BE7), width: 2.0),
                                right: BorderSide(
                                    color: Color(0xFF3D8BE7), width: 2.0),
                                bottom: BorderSide(
                                    color: Color(0xFF3D8BE7), width: 2.0))),
                        child: ListView(
                          shrinkWrap: true,
                          children: groupList.map((item) {
                            return Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 166, 166, 166)),
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
                                                style: const TextStyle(
                                                    fontSize: 30)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    height: 77,
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
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
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
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
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
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
                                    color: const Color.fromARGB(
                                        255, 166, 166, 166),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13.0),
                                    child: IconButton(
                                      onPressed: () async {
                                        await deleteItemFromTable(
                                            widget.table.firebaseId, item.name);
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
                              left: BorderSide(
                                  color: Color(0xFF3D8BE7), width: 2.0),
                              right: BorderSide(
                                  color: Color(0xFF3D8BE7), width: 2.0),
                              bottom: BorderSide(
                                  color: Color(0xFF3D8BE7), width: 2.0))),
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
                                "${orderList.length}",
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF3D8BE7)),
                                ),
                                onPressed: () {
                                  widget.goToMapaPage();
                                },
                                child: SizedBox(
                                  width: w,
                                  height: h,
                                  child: const Align(
                                    child: Text(
                                      'MAPA MESAS',
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFB0D5FF)),
                                ),
                                onPressed: () async {
                                  if (widget.table.orders.isNotEmpty) {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => PaymentDialog(
                                              cardAction: () {
                                                deleteTable(
                                                    widget.table.firebaseId);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              table: widget.table,
                                            ));
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: w,
                                  height: h,
                                  child: const Align(
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF3D8BE7)),
                                ),
                                onPressed: () {
                                  if (widget.table.orders.isNotEmpty) {
                                    deleteTable(widget.table.firebaseId);
                                    Navigator.pop(context);
                                  }
                                },
                                child: SizedBox(
                                  width: w,
                                  height: h,
                                  child: const Align(
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
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFB0D5FF)),
                                ),
                                onPressed: () {
                                  previousTable();
                                },
                                child: SizedBox(
                                  width: w,
                                  height: h,
                                  child: Align(
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 27.0),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.blue,
                                          size: 80,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF3D8BE7)),
                                ),
                                onPressed: () {
                                  if (newItemsList.isNotEmpty) {
                                    addListItemToTable(
                                        newItemsList, widget.table.firebaseId);
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: SizedBox(
                                  width: w,
                                  height: h,
                                  child: const Align(
                                    child: Text(
                                      'ENVIAR',
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 5),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFFB0D5FF)),
                                ),
                                onPressed: () async {
                                  nextTable();
                                },
                                child: SizedBox(
                                  width: w,
                                  height: h,
                                  child: Align(
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.blue,
                                          size: 80,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 4.0),
          //MENU
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: SizedBox(
              width: 1200,
              height: 1375,
              child: FutureBuilder<List<Category>>(
                  future: getCategories(),
                  builder: (context, snapshot) {
                    int rowCountCategories = (categories.length / 5).ceil();
                    int rowCountSubcategories =
                        (currentCategory.subcategories.length / 5).ceil();
                    int rowCountItems =
                        (currentSubcategory.items.length / 5).ceil();
                    return Column(
                      children: [
                        Column(
                          children:
                              List.generate(rowCountCategories, (rowIndex) {
                            int startIndex = rowIndex * 5;
                            int endIndex = (rowIndex + 1) * 5;
                            if (endIndex > categories.length) {
                              endIndex = categories.length;
                            }

                            List<Category?> rowCategories = List.from(
                                categories.sublist(startIndex, endIndex));
                            rowCategories.addAll(
                                List.filled(5 - (endIndex - startIndex), null));

                            return _buildButtonRow(rowCategories,
                                _handleCategoryButtonPressed, categoryColor);
                          }),
                        ),
                        Column(
                          children:
                              List.generate(rowCountSubcategories, (rowIndex) {
                            int startIndex = rowIndex * 5;
                            int endIndex = (rowIndex + 1) * 5;
                            if (endIndex >
                                currentCategory.subcategories.length) {
                              endIndex = currentCategory.subcategories.length;
                            }

                            List<Subcategory?> rowSubcategories = List.from(
                                currentCategory.subcategories
                                    .sublist(startIndex, endIndex));
                            rowSubcategories.addAll(
                                List.filled(5 - (endIndex - startIndex), null));

                            return _buildButtonRow(
                                rowSubcategories,
                                _handleSubcategoryButtonPressed,
                                subcategoryColor);
                          }),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                currentCategory.name == 'COMIDAS' ? 907 : 675,
                          ),
                          child: ListView(
                            children: [
                              Column(
                                children:
                                    List.generate(rowCountItems, (rowIndex) {
                                  int startIndex = rowIndex * 5;
                                  int endIndex = (rowIndex + 1) * 5;
                                  if (endIndex >
                                      currentSubcategory.items.length) {
                                    endIndex = currentSubcategory.items.length;
                                  }

                                  List<Item?> rowItems = List.from(
                                    currentSubcategory.items
                                        .sublist(startIndex, endIndex),
                                  );
                                  rowItems.addAll(List.filled(
                                      5 - (endIndex - startIndex), null));

                                  return _buildButtonRow(rowItems,
                                      _handleItemButtonPressed, itemColor);
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  nextTable() async {
    int actualId = int.parse(widget.table.id);
    int newId = actualId + 1;
    if (newId > 26) {
      newId = 1;
    }
    print(newId);
    CustomTable? newTable = await getTableById(newId);

    widget.goToOrderPage(newTable!);
  }

  void previousTable() async {
    int actualId = int.parse(widget.table.id);
    int newId = actualId - 1;
    if (newId < 1) {
      newId = 26;
    }
    print(newId);
    CustomTable? newTable = await getTableById(newId);

    widget.goToOrderPage(newTable!);
  }

  List<Group> _getGroupedOrder() {
    Map<String, Group> orderGroup = {};

    for (var item in orderList) {
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

  Widget _buildButtonRow(
      List<dynamic> objetc, Function onPressed, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: objetc.map((item) {
        if (item != null) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                onPressed: () => onPressed(item),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                ),
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    color: color,
                  ),
                  child: Center(
                    child: item.name != null
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              item.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Stack(
                children: [
                  Center(
                    child: Opacity(
                      opacity: 0.15, // Ajusta la opacidad según tus necesidades
                      child: Container(
                        width: 200,
                        child: Image.asset(
                          'lib/assets/images/menu_null_nombre.jpg',
                          fit: BoxFit
                              .fill, // Ajusta el modo de ajuste según tus necesidades
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  void _handleCategoryButtonPressed(Category category) {
    setState(() {
      currentCategory = category;
      currentSubcategory = category.subcategories.first;
    });
  }

  void _handleSubcategoryButtonPressed(Subcategory subcategory) {
    setState(() {
      currentSubcategory = subcategory;
    });
  }

  void _handleItemButtonPressed(Item item) {
    newItemsList.add(item);
    orderList.add(item);
    setState(() {
      groupList = _getGroupedOrder();
      totalPrice = orderList
          .map((e) => e.price)
          .fold(0, (value, element) => value + element);
    });
  }

  void _loadDataMenu() async {
    var loadedCategories = await getCategories();

    setState(() {
      categories = loadedCategories;
      currentCategory = categories.first;
      currentSubcategory = currentCategory.subcategories.first;
      currentSubcategoryItemList = currentSubcategory.items;
    });
  }

  void _loadDataBill() {
    orderList = widget.table.orders;
    groupList = _getGroupedOrder();
    totalPrice = orderList
        .map((e) => e.price)
        .fold(0, (value, element) => value + element);
  }
}
