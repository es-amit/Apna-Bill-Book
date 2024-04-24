import 'dart:developer';

import 'package:apna_bill_book/data/model/item_model.dart';
import 'package:hive/hive.dart';

abstract interface class ItemsLocalDataSource {
  void addToFavorites({
    required ItemModel item,
  });

  void removeFromFavorites({
    required int itemId,
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
        final id = itemJson['id'] as int;
        final name = itemJson['name'];
        final int price = itemJson['mrp'];
        final category = itemJson['productCategory'];

        log(ItemModel(
                id: id, name: '$name', price: price, category: '$category')
            .toString());
        items.add(
          ItemModel(id: id, name: '$name', price: price, category: '$category'),
        );
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
      log(item.id.toString());
      log(item.toJson().toString());
      box.put(item.id.toString(), item.toJson());
    } catch (e) {
      log('Error adding to favorites: $e');
      // Handle the error here, or rethrow if necessary
    }
  }

  @override
  Future<void> removeFromFavorites({required int itemId}) async {
    try {
      box.delete(itemId.toString());
    } catch (e) {
      log('Error removing from favorites: $e');
      // Handle the error here, or rethrow if necessary
    }
  }
}
