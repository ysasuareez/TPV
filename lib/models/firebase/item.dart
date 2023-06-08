/// Modelo de un item
class Item {
  final String id;
  String name;
  final double price;

  Item({required this.id, required this.name, required this.price});

  @override
  String toString() {
    return id + name;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "price": price,
    };
  }
}
