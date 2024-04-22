import 'dart:convert';
import 'dart:developer';

import 'package:apna_bill_book/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

import 'package:apna_bill_book/data/model/item_model.dart';

abstract interface class ListRemoteDataSource {
  Future<List<ItemModel>> fetchItems(int page);
}

class ListRemoteDataSourceImpl implements ListRemoteDataSource {
  @override
  Future<List<ItemModel>> fetchItems(int page) async {
    try {
      log('message');
      final response = await http.get(
        Uri.parse(
          'https://app.apnabillbook.com/api/product?storeId=4ad3de84-bcaa-4bb2-9eb9-1846844e3314&page=$page&pageSize=10',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data']['data'];
        return data.map<ItemModel>((item) {
          log(item.toString());
          return ItemModel.fromJson(item as Map<String, dynamic>);
        }).toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      log('error: $e');
      throw ServerException('Failed to fetch items: $e');
    }
  }
}
