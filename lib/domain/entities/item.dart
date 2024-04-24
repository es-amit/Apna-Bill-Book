import 'package:uuid/uuid.dart';

class Item {
  final String id;
  final String name;
  final int price;
  final String category;

  Item({
    required this.name,
    required this.price,
    required this.category,
  }) : id = const Uuid().v4();
}
