import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurante/models/firebase/category.dart';
import 'package:restaurante/models/firebase/employe.dart';
import 'package:restaurante/models/firebase/item.dart';
import 'package:restaurante/models/firebase/subcategory.dart';
import 'package:restaurante/models/firebase/customTable.dart';
import 'package:restaurante/models/utils/group.dart';

/// Servicio de Firebase
FirebaseFirestore db = FirebaseFirestore.instance;

/// Obtiene la lista de mesas de la base de datos
Future<List<CustomTable>> getTables() async {
  CollectionReference tablesCollection = db.collection('customeTable');
  QuerySnapshot querySnapshot = await tablesCollection.get();

  List<CustomTable> tables = [];
  for (var tableDocument in querySnapshot.docs) {
    Map<String, dynamic> data = tableDocument.data() as Map<String, dynamic>;
    if (data.isEmpty) continue;

    String tableId = tableDocument.get('id').toString();
    String firebaseId = tableDocument.id;

    CollectionReference ordersCollection =
        tableDocument.reference.collection('orders');
    QuerySnapshot ordersSnapshot = await ordersCollection.get();

    List<Item> orders = [];
    for (var orderDocument in ordersSnapshot.docs) {
      Map<String, dynamic> data = orderDocument.data() as Map<String, dynamic>;
      if (data.isEmpty) continue;
      String id = orderDocument.id;
      String name = orderDocument.get('name');
      double price = orderDocument.get('price');

      Item item = Item(id: id, name: name, price: price);
      orders.add(item);
    }

    CustomTable table =
        CustomTable(firebaseId: firebaseId, id: tableId, orders: orders);
    tables.add(table);
  }

  return tables;
}

Future<CustomTable?> getTableById(int id) async {
  CollectionReference tablesCollection = db.collection('customeTable');
  QuerySnapshot querySnapshot =
      await tablesCollection.where('id', isEqualTo: id).get();

  var tableDocument;
  if (querySnapshot.docs.isNotEmpty) {
    tableDocument = querySnapshot.docs[0];
    Map<String, dynamic> data = tableDocument.data() as Map<String, dynamic>;

    String tableId = tableDocument.get('id').toString();
    String firebaseId = tableDocument.id;

    CollectionReference ordersCollection =
        tableDocument.reference.collection('orders');
    QuerySnapshot ordersSnapshot = await ordersCollection.get();

    List<Item> orders = [];
    for (var orderDocument in ordersSnapshot.docs) {
      Map<String, dynamic> data = orderDocument.data() as Map<String, dynamic>;
      if (data.isEmpty) continue;
      String id = orderDocument.id;
      String name = orderDocument.get('name');
      double price = orderDocument.get('price');

      Item item = Item(id: id, name: name, price: price);
      orders.add(item);
    }

    CustomTable table =
        CustomTable(firebaseId: firebaseId, id: tableId, orders: orders);
    return table;
  } else {
    return null;
  }
}

Future<List<Item>> getOrderFromTable(CustomTable table) async {
  List<Item> orders = [];

  CollectionReference ordersCollection =
      db.collection('customeTable').doc(table.firebaseId).collection('orders');

  QuerySnapshot querySnapshot = await ordersCollection.get();
  for (var document in querySnapshot.docs) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data.isEmpty) continue;

    String id = document.id;
    String name = document.get('name');
    double price = document.get('price');

    Item item = Item(id: id, name: name, price: price);
    orders.add(item);
  }

  return orders;
}

/// Obtiene la lista de empleados de la base de datos
Future<List<Employee>> getEmployees() async {
  List<Employee> employees = [];

  List<QueryDocumentSnapshot<Object?>> employeesCollection =
      await _getCollection('employees');
  for (var employeeDocument in employeesCollection) {
    String id = employeeDocument.id;
    String name = employeeDocument.get('name');
    int pin = employeeDocument.get('pin');

    Employee employee = Employee(id: id, name: name, pin: pin);
    employees.add(employee);
  }

  return employees;
}

Future<Employee?> getEmployeeByPIN(int pin) async {
  CollectionReference tablesCollection = db.collection('employees');
  QuerySnapshot querySnapshot =
      await tablesCollection.where('pin', isEqualTo: pin).get();

  if (querySnapshot.size == 0) {
    return null;
  }

  var employeeDocument = querySnapshot.docs[0];
  Map<String, dynamic> data = employeeDocument.data() as Map<String, dynamic>;

  return Employee(
      id: employeeDocument.id,
      name: employeeDocument.get('name'),
      pin: employeeDocument.get('pin'));
}

/// Obtiene la lista de categorías de la base de datos
Future<List<Category>> getCategories() async {
  List<Category> categories = [];

  List<QueryDocumentSnapshot<Object?>> categoriesCollection =
      await _getCollection('categories');
  for (var categoryDocument in categoriesCollection) {
    String id = categoryDocument.id;
    String name = categoryDocument.get('name');

    List<QueryDocumentSnapshot<Object?>> subcategoriesCollection =
        await _getCollectionFromDocument('subcategories', categoryDocument);

    List<Subcategory> subcategories = [];
    for (var subcategoryDocument in subcategoriesCollection) {
      String id = subcategoryDocument.id;
      String subcategoryName = subcategoryDocument.get('name');

      List<QueryDocumentSnapshot<Object?>> itemsCollection =
          await _getCollectionFromDocument('items', subcategoryDocument);

      List<Item> items = [];
      for (var itemDocument in itemsCollection) {
        String id = itemDocument.id;
        String name = itemDocument.get('name');
        double price = double.parse(itemDocument.get('price').toString());

        Item item = Item(id: id, name: name, price: price);
        items.add(item);
      }

      Subcategory subcategory =
          Subcategory(id: id, name: subcategoryName, items: items);
      subcategories.add(subcategory);
    }

    Category category =
        Category(id: id, name: name, subcategories: subcategories);
    categories.add(category);
  }

  return categories;
}

/**
 * 
 */
Future<void> addCategory(Category category) async {
  CollectionReference categoryCollection = db.collection('categories');

  // Obtener el ID de la categoría
  String categoryId = category.id;

  // Crear la categoría principal con el ID personalizado
  await categoryCollection.doc(categoryId).set({
    'name': category.name,
  });

  // Recorrer las subcategorías de la categoría
  for (var subcategory in category.subcategories) {
    // Obtener el ID de la subcategoría
    String subcategoryId = subcategory.id;

    // Crear la subcategoría con el ID personalizado
    await categoryCollection
        .doc(categoryId)
        .collection('subcategories')
        .doc(subcategoryId)
        .set({
      'name': subcategory.name,
    });

    // Recorrer los items de la subcategoría
    for (var item in subcategory.items) {
      // Obtener el ID del item
      String itemId = item.id;

      // Crear el item con el ID personalizado
      await categoryCollection
          .doc(categoryId)
          .collection('subcategories')
          .doc(subcategoryId)
          .collection('items')
          .doc(itemId)
          .set({
        'id': item.id,
        'name': item.name,
        'price': item.price,
      });
    }
  }
}

/**
 * INUTILIZADO POR AHORA
 */
Future<void> saveOrders(List<Item> orders, String tableId) async {
  if (orders.isEmpty) return;
  if (tableId.isEmpty) return;

  CollectionReference ordersCollection =
      db.collection('customeTable').doc(tableId).collection('orders');

  // Remove all data from orders collection
  QuerySnapshot querySnapshot = await ordersCollection.get();
  for (var document in querySnapshot.docs) {
    await document.reference.delete();
  }

  for (var item in orders) {
    await ordersCollection.doc(item.id).set({
      'name': item.name,
      'price': item.price,
    });
  }
}

Future<void> addListItemToTable(
    List<Item> orders, String tableFirebaseId) async {
  for (var item in orders) {
    DocumentReference<Map<String, dynamic>> ordersCollection = db
        .collection('customeTable')
        .doc(tableFirebaseId)
        .collection('orders')
        .doc('${DateTime.now()}');

    await ordersCollection.set({
      'name': item.name,
      'price': item.price,
    });
  }
}

Future<void> addItemToTable(Item item, CustomTable table) async {
  DocumentReference<Map<String, dynamic>> ordersCollection = db
      .collection('customeTable')
      .doc(table.firebaseId)
      .collection('orders')
      .doc('${DateTime.now()}');

  await ordersCollection.set({
    'name': item.name,
    'price': item.price,
  });
}

Future<void> deleteItemFromTable(String firebaseId, String itemName) async {
  try {
    // Obtener la referencia a la colección "orders" de la mesa
    CollectionReference ordersCollection = FirebaseFirestore.instance
        .collection('customeTable')
        .doc(firebaseId)
        .collection('orders');

    // Obtener la referencia al ítem por su nombre
    QuerySnapshot querySnapshot =
        await ordersCollection.where('name', isEqualTo: itemName).get();
    if (querySnapshot.docs.isNotEmpty) {
      // Eliminar el primer ítem encontrado (asumiendo que no hay duplicados del mismo nombre)
      await querySnapshot.docs.first.reference.delete();
    } else {}
  } catch (error) {}
}

/**
*  Elimina una mesa de la base de datos
*/
Future<void> deleteTable(String tableFirebaseId) async {
  int i = 0;
  CollectionReference ordersCollection =
      db.collection('customeTable').doc(tableFirebaseId).collection('orders');

  // Remove all data from orders collection
  QuerySnapshot querySnapshot = await ordersCollection.get();
  for (var document in querySnapshot.docs) {
    await document.reference.delete();
  }
}

Future<void> moveTable(
    List<CustomTable> tableList, CustomTable destinyTable) async {
  List<CustomTable> copyList = List.from(tableList);
  for (var t in copyList) {
    for (var item in t.orders) {
      await db
          .collection('customeTable')
          .doc(destinyTable.firebaseId)
          .collection('orders')
          .add(item.toMap());
    }

    await deleteTable(t.firebaseId);
  }
}

/**
 *  Elimina una lista de mesas de la base de datos
 */
Future<void> deleteListTable(List<CustomTable> selectedTablesList) async {
  for (var t in selectedTablesList) {
    if (t.firebaseId.isEmpty) return;

    CollectionReference ordersCollection =
        db.collection('customeTable').doc(t.firebaseId).collection('orders');

    QuerySnapshot querySnapshot = await ordersCollection.get();
    for (var document in querySnapshot.docs) {
      await document.reference.delete();
    }
  }
}

/// Obtiene la lista de artículos de la base de datos
/// - category: Nombre de la categoría
Future<List<QueryDocumentSnapshot<Object?>>> _getCollection(
    String collection) async {
  CollectionReference collectionReference = db.collection(collection);
  QuerySnapshot querySnapshot = await collectionReference.get();

  return querySnapshot.docs;
}

/// Obtiene una colección de la base de datos
/// La clase QueryDocumentSnapshot permite obtener la información de una colección de Firebase.
/// - collection: Nombre de la colección
/// - document: Documento de referencia
Future<List<QueryDocumentSnapshot<Object?>>> _getCollectionFromDocument(
    String collection, QueryDocumentSnapshot<Object?> document) async {
  CollectionReference collectionReference =
      document.reference.collection(collection);
  QuerySnapshot querySnapshot = await collectionReference.get();

  return querySnapshot.docs;
}

/// Obtiene la lista de documentos de la base de datos.
/// La clase DocumentSnapshot permite obtener la información de un documento de Firebase.
/// - collection: Nombre de la colección
/// - document: Nombre del documento
Future<DocumentSnapshot<Object?>> getDocument(
    String collection, String document) async {
  DocumentReference documentReference = db.collection(collection).doc(document);
  DocumentSnapshot documentSnapshot = await documentReference.get();

  return documentSnapshot;
}
