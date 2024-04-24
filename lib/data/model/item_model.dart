import 'package:apna_bill_book/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.name,
    required super.price,
    required super.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mrp': price,
      'productCategory': category,
    };
  }

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['mrp'] as int, // Changed from int to double
      category: map['productCategory']['name'] as String,
    );
  }

  factory ItemModel.fromItem(Item item) {
    return ItemModel(
      id: item.id,
      name: item.name,
      price: item.price,
      category: item.category,
    );
  }

  @override
  String toString() {
    return 'ItemModel{id: $id, name: $name, price: $price, category: $category}';
  }
}
