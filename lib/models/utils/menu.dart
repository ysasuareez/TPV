import 'package:flutter/material.dart';
import 'package:restaurante/models/firebase/customTable.dart';

import '../firebase/category.dart';
import '../firebase/item.dart';
import '../firebase/subcategory.dart';
import '../../services/firebase_service.dart';

class MenuPage extends StatefulWidget {
  final CustomTable table;
  final Function() reload;
  const MenuPage({super.key, required this.table, required this.reload});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Color categoryColor = Color(0xFF5DDAAD);
  Color subcategoryColor = Color(0xFFFFD056);
  Color itemColor = Color(0xFFDA71FF);
  List<Category> categories = [];
  Category currentCategory = Category(id: "", name: "", subcategories: []);
  Subcategory currentSubcategory = Subcategory(id: "", name: "", items: []);
  List<Item> currentSubcategoryItemList = [];
  List<Item> orderList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
        future: getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          int rowCountCategories = (categories.length / 5).ceil();
          int rowCountSubcategories =
              (currentCategory.subcategories.length / 5).ceil();
          int rowCountItems = (currentSubcategory.items.length / 5).ceil();
          return Column(
            children: [
              Column(
                children: List.generate(rowCountCategories, (rowIndex) {
                  int startIndex = rowIndex * 5;
                  int endIndex = (rowIndex + 1) * 5;
                  if (endIndex > categories.length) {
                    endIndex = categories.length;
                  }

                  List<Category?> rowCategories =
                      List.from(categories.sublist(startIndex, endIndex));
                  rowCategories
                      .addAll(List.filled(5 - (endIndex - startIndex), null));

                  return _buildButtonRow(rowCategories,
                      _handleCategoryButtonPressed, categoryColor);
                }),
              ),
              Column(
                children: List.generate(rowCountSubcategories, (rowIndex) {
                  int startIndex = rowIndex * 5;
                  int endIndex = (rowIndex + 1) * 5;
                  if (endIndex > currentCategory.subcategories.length) {
                    endIndex = currentCategory.subcategories.length;
                  }

                  List<Subcategory?> rowSubcategories = List.from(
                      currentCategory.subcategories
                          .sublist(startIndex, endIndex));
                  rowSubcategories
                      .addAll(List.filled(5 - (endIndex - startIndex), null));

                  return _buildButtonRow(rowSubcategories,
                      _handleSubcategoryButtonPressed, subcategoryColor);
                }),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: currentCategory.name == 'COMIDAS' ? 907 : 675,
                ),
                child: ListView(
                  children: [
                    Column(
                      children: List.generate(rowCountItems, (rowIndex) {
                        int startIndex = rowIndex * 5;
                        int endIndex = (rowIndex + 1) * 5;
                        if (endIndex > currentSubcategory.items.length) {
                          endIndex = currentSubcategory.items.length;
                        }

                        List<Item?> rowItems = List.from(
                          currentSubcategory.items
                              .sublist(startIndex, endIndex),
                        );
                        rowItems.addAll(
                            List.filled(5 - (endIndex - startIndex), null));

                        return _buildButtonRow(
                            rowItems, _handleItemButtonPressed, itemColor);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
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

  Future<void> _handleItemButtonPressed(Item item) async {
    await addItemToTable(item, widget.table);
    widget.reload();
  }

  void _loadData() async {
    var loadedCategories = await getCategories();

    setState(() {
      categories = loadedCategories;
      currentCategory = categories.first;
      currentSubcategory = currentCategory.subcategories.first;
      currentSubcategoryItemList = currentSubcategory.items;
    });
  }
}
