import 'package:flutter/material.dart';
import 'package:restaurante/models/item.dart';
import 'package:restaurante/models/subcategory.dart';
import 'package:restaurante/services/firebase_service.dart';

import '../dialogs/byeDialog.dart';
import '../dialogs/cashDialog.dart';
import '../dialogs/deleteDialog.dart';
import '../dialogs/paymentDialong.dart';
import '../models/category.dart';
import '../models/customTable.dart';
import '../utils/group.dart';

/// Represent a page where orders are managed for a specific table.
class OrdersPage extends StatefulWidget {
  /// It contains the following properties:
  /// A function that navigates to the order page. Used to reinvoke.
  final void Function(CustomTable) goToOrderPage;

  /// A function that navigates to the mapa page.
  final void Function() goToMapaPage;

  /// This property represents the current table being managed on the order page.
  final CustomTable table;

  const OrdersPage({
    super.key,
    required this.table,
    required this.goToMapaPage,
    required this.goToOrderPage,
  });

  @override
  OrdersPageState createState() => OrdersPageState();
}

class OrdersPageState extends State<OrdersPage> {
  /// DESING MENU
  Color categoryColor = const Color(0xFF5DDAAD);
  Color subcategoryColor = const Color(0xFFFFD056);
  Color itemColor = const Color(0xFFDA71FF);
  List<Category> categories = [];
  Category currentCategory = Category(id: "", name: "", subcategories: []);
  Subcategory currentSubcategory = Subcategory(id: "", name: "", items: []);
  List<Item> currentSubcategoryItemList = [];

  /// SIZE BUTTONS
  double w = 255;
  double h = 230;

  /// UTILS
  /// It is a list that holds the ordered items for the table.
  List<Group> groupList = [];

  /// This list contains the newly added items that are yet to be sent.
  List<Item> newItemsList = [];

  /// Represents the total price of the ordered items.
  double totalPrice = 0;

  /// It is a list that holds the grouped order items.
  List<Item> orderList = [];

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
    _loadDataMenu();
    _loadDataBill();
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
          Row(
            children: [
              Column(
                children: [
                  //BILL
                  Padding(
                    padding: const EdgeInsets.only(left: 9, top: 40),
                    child: Column(
                      children: [
                        Container(
                          width: 870,
                          height: 78,
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
                          height: 78,
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
                                  child: Text("UDS",
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
                                  child: Text("TOTAL",
                                      style: TextStyle(fontSize: 30)),
                                ),
                              ),
                              Container(
                                width: 1.5,
                                color: const Color.fromARGB(255, 166, 166, 166),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 870,
                          height: 628,
                          decoration: const BoxDecoration(
                              color: Colors.white,
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
                                      color:
                                          Color.fromARGB(255, 166, 166, 166)),
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
                                            style:
                                                const TextStyle(fontSize: 30)),
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
                                            style:
                                                const TextStyle(fontSize: 30)),
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
                                            style:
                                                const TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                    Container(
                                      height: 77,
                                      width: 1.5,
                                      color: const Color.fromARGB(
                                          255, 166, 166, 166),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 13.0),
                                      child: IconButton(
                                        onPressed: () {
                                          if (orderList.contains(
                                              orderList.firstWhere((element) =>
                                                  element.name == item.name))) {
                                            orderList.remove(orderList
                                                .firstWhere((element) =>
                                                    element.name == item.name));
                                          } else if (newItemsList.contains(
                                              newItemsList.firstWhere(
                                                  (element) =>
                                                      element.name ==
                                                      item.name))) {
                                            newItemsList.remove(newItemsList
                                                .firstWhere((element) =>
                                                    element.name == item.name));
                                          }

                                          setState(() {
                                            _loadDataBill();
                                          });
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
                        Container(
                          height: 107,
                          width: 870,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF3D8BE7), width: 2.0),
                                  right: BorderSide(
                                      color: Color(0xFF3D8BE7), width: 2.0),
                                  bottom: BorderSide(
                                      color: Color(0xFF3D8BE7), width: 2.0))),
                          child: Row(
                            children: [
                              const Padding(
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
                              SizedBox(
                                width: 540,
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
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "$totalPrice€",
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
                                      if (newItemsList.isNotEmpty) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => DeleteDialog(
                                                  afirmativeAction: () {
                                                    Navigator.pop(context);
                                                    widget.goToMapaPage();
                                                  },
                                                ));
                                      } else {
                                        widget.goToMapaPage();
                                      }
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
                                                  table: widget.table,
                                                  cardAction: () async {
                                                    await updateTable(
                                                        widget.table,
                                                        'cobrada');

                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });

                                                    widget.goToMapaPage();

                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            const ByeDialog());
                                                    await closeTable(
                                                      widget.table,
                                                    );
                                                  },
                                                  cashAction: () async {
                                                    Navigator.pop(context);
                                                    await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          CashDialog(
                                                        table: widget.table,
                                                        cobrarAction: () async {
                                                          await updateTable(
                                                              widget.table,
                                                              'cobrada');

                                                          setState(() {
                                                            Navigator.pop(
                                                                context);
                                                          });

                                                          widget.goToMapaPage();

                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  const ByeDialog());
                                                          await closeTable(
                                                            widget.table,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ));
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
                                      if (orderList.isNotEmpty ||
                                          newItemsList.isNotEmpty) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => DeleteDialog(
                                                  afirmativeAction: () async {
                                                    await updateTable(
                                                        widget.table,
                                                        'eliminada');

                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                    widget.goToMapaPage();

                                                    await closeTable(
                                                      widget.table,
                                                    );
                                                  },
                                                ));
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
                                            padding:
                                                EdgeInsets.only(left: 27.0),
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
                                    onPressed: () async {
                                      if (newItemsList.isNotEmpty) {
                                        await addListItemToTable(newItemsList,
                                            widget.table.firebaseId);
                                        await openTable(
                                          widget.table,
                                        );
                                        newItemsList.clear();
                                        widget.goToMapaPage();
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
                                            padding:
                                                EdgeInsets.only(left: 10.0),
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
                                rowCategories.addAll(List.filled(
                                    5 - (endIndex - startIndex), null));

                                return _buildButtonRow(
                                    rowCategories,
                                    _handleCategoryButtonPressed,
                                    categoryColor);
                              }),
                            ),
                            Column(
                              children: List.generate(rowCountSubcategories,
                                  (rowIndex) {
                                int startIndex = rowIndex * 5;
                                int endIndex = (rowIndex + 1) * 5;
                                if (endIndex >
                                    currentCategory.subcategories.length) {
                                  endIndex =
                                      currentCategory.subcategories.length;
                                }

                                List<Subcategory?> rowSubcategories = List.from(
                                    currentCategory.subcategories
                                        .sublist(startIndex, endIndex));
                                rowSubcategories.addAll(List.filled(
                                    5 - (endIndex - startIndex), null));

                                return _buildButtonRow(
                                    rowSubcategories,
                                    _handleSubcategoryButtonPressed,
                                    subcategoryColor);
                              }),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: currentCategory.name == 'COMIDAS'
                                    ? 907
                                    : 675,
                              ),
                              child: ListView(
                                children: [
                                  Column(
                                    children: List.generate(rowCountItems,
                                        (rowIndex) {
                                      int startIndex = rowIndex * 5;
                                      int endIndex = (rowIndex + 1) * 5;
                                      if (endIndex >
                                          currentSubcategory.items.length) {
                                        endIndex =
                                            currentSubcategory.items.length;
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
        ],
      ),
    );
  }

  /// This method is responsible for navigating to the next table. It updates
  /// the current table ID and retrieves the corresponding table data. It then
  /// updates the state and calls widget.goToOrderPage() to navigate to the
  /// order page for the new table.
  void nextTable() async {
    int actualId = widget.table.id;
    int newId = actualId + 1;
    if (newId > 26) {
      newId = 1;
    }
    CustomTable? newTable = await getTableById(newId);

    setState(() {
      widget.goToOrderPage(newTable!);
    });
  }

  /// Similar to nextTable(), this method navigates to the previous table.
  void previousTable() async {
    int actualId = widget.table.id;
    int newId = actualId - 1;
    if (newId < 1) {
      newId = 26;
    }
    CustomTable? newTable = await getTableById(newId);

    setState(() {
      widget.goToOrderPage(newTable!);
    });
  }

  ///This method takes the orderList and groups the ordered items based on their
  /// name and price. It returns a list of Group objects that represent the
  ///  grouped items.
  List<Group> _getGroupedOrder() {
    Map<String, Group> orderGroup = {};

    for (var item in orderList) {
      String key = '${item.name}-${item.price}';
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

  /// This method constructs a row of buttons based on the provided list of
  ///  objects (categories, subcategories, or items). It maps each object to an
  ///  ElevatedButton widget and assigns the corresponding onPressed function.
  ///  The buttons are then arranged in a row and returned as a Row widget.
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
                  padding: const EdgeInsets.all(0),
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
              padding: const EdgeInsets.all(1.0),
              child: Stack(
                children: [
                  Container(
                    height: h,
                    width: w,
                    color: Colors.white,
                    child: Center(
                      child: Opacity(
                        opacity: 0.15,
                        child: SizedBox(
                          width: 200,
                          child: Image.asset(
                            'lib/assets/images/menu_null_nombre.jpg',
                            fit: BoxFit.fill,
                          ),
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

  /// This method is called when a category button is pressed. It updates the
  /// currentCategory and currentSubcategory properties based on the selected
  ///  category.
  void _handleCategoryButtonPressed(Category category) {
    setState(() {
      currentCategory = category;
      currentSubcategory = category.subcategories.first;
    });
  }

  /// Similar to _handleCategoryButtonPressed
  void _handleSubcategoryButtonPressed(Subcategory subcategory) {
    setState(() {
      currentSubcategory = subcategory;
    });
  }

  /// This method is called when an item button is pressed. It adds the selected
  /// item to both the newItemsList and orderList, updates the groupList, and
  /// recalculates the totalPrice.
  void _handleItemButtonPressed(Item item) {
    newItemsList.add(item);
    orderList.add(item);
    setState(() {
      groupList = _getGroupedOrder();
      totalPrice = orderList
          .map((e) => e.price)
          .fold(0, (value, element) => value + element);
    });
    openTable(widget.table);
  }

  /// This method loads the menu data, including categories, subcategories, and
  ///  items. It initializes the categories, currentCategory, currentSubcategory,
  ///  and currentSubcategoryItemList properties.
  void _loadDataMenu() async {
    var loadedCategories = await getCategories();

    categories = loadedCategories;
    currentCategory = categories.first;
    currentSubcategory = currentCategory.subcategories.first;
    currentSubcategoryItemList = currentSubcategory.items;
  }

  ///_loadDataBill(): This method loads the order data for the current table.
  /// It populates the orderList, groupList, and totalPrice based on the
  ///  existing orders.
  void _loadDataBill() {
    orderList = widget.table.orders;
    groupList = _getGroupedOrder();
    totalPrice = orderList
        .map((e) => e.price)
        .fold(0, (value, element) => value + element);
  }
}
