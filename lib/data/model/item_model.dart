import 'package:apna_bill_book/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.name,
    required super.price,
    required super.category,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
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
}
