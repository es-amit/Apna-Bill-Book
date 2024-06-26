import 'package:apna_bill_book/data/model/item_model.dart';
import 'package:hive/hive.dart';

abstract interface class ItemsLocalDataSource {
  void addToFavorites({
    required ItemModel item,
  });

  Future<List<ItemModel>> removeFromFavorites({
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

        items.add(
          ItemModel(id: id, name: '$name', price: price, category: '$category'),
        );
      }
    } catch (e) {
      return [];
      // Handle the error here, or rethrow if necessary
    }
    return items;
  }

  @override
  Future<void> addToFavorites({required ItemModel item}) async {
    try {
      box.put(item.id.toString(), item.toJson());
    } catch (e) {
      // Handle the error here, or rethrow if necessary
    }
  }

  @override
  Future<List<ItemModel>> removeFromFavorites({required int itemId}) async {
    try {
      box.delete(itemId.toString());
      final result = await loadFavorites();
      return result;
    } catch (e) {
      // Handle the error here, or rethrow if necessary
      return [];
    }
  }
}
