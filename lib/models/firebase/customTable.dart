import 'item.dart';

/// Modelo de una tabla
class CustomTable {
  String firebaseId;
  String id;
  List<Item> orders;

  CustomTable(
      {required this.firebaseId, required this.id, required this.orders});

  bool get isBusy => orders.isNotEmpty;

  int getUnits() {
    return orders.length;
  }

  double getTotalAmount() {
    double total = 0.0;
    for (var item in orders) {
      total += item.price;
    }
    return total;
  }
}
