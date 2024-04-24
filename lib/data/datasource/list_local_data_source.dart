import 'dart:developer';

import 'package:apna_bill_book/data/model/item_model.dart';
import 'package:hive/hive.dart';

abstract interface class ItemsLocalDataSource {
  void addToFavorites({
    required ItemModel item,
  });

  void removeFromFavorites({
    required String itemId,
  });

  Future<List<ItemModel>> loadFavorites();
}

class ItemsLocalDataSourceImpl implements ItemsLocalDataSource {
  final Box box;
  ItemsLocalDataSourceImpl(this.box);

  @override
  Future<List<ItemModel>> loadFavorites() async {
    List<ItemModel> items = [];
    try {
      for (var key in box.keys) {
        final Map<String, dynamic> itemJson = box.get(key);
        final name = itemJson['name'];
        final int price = itemJson['mrp'];
        final category = itemJson['productCategory'];

        items
            .add(ItemModel(name: '$name', price: price, category: '$category'));
      }
    } catch (e) {
      log('Error loading favorites: $e');
      // Handle the error here, or rethrow if necessary
    }
    return items;
  }

  @override
  Future<void> addToFavorites({required ItemModel item}) async {
    try {
      log(item.id);
      log(item.toJson().toString());
      box.put(item.id, item.toJson());
    } catch (e) {
      log('Error adding to favorites: $e');
      // Handle the error here, or rethrow if necessary
    }
  }

  @override
  void removeFromFavorites({required String itemId}) {
    box.delete(itemId);
  }
}
