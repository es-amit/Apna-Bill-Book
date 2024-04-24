import 'package:apna_bill_book/core/error/exceptions.dart';
import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/data/datasource/list_local_data_source.dart';
import 'package:apna_bill_book/data/datasource/list_remote_data_source.dart';
import 'package:apna_bill_book/data/model/item_model.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListRepositoryImpl implements ListRepository {
  final ListRemoteDataSource remoteDataSource;
  final ItemsLocalDataSource localDataSource;

  ListRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<Item>>> fetchItems(int page) async {
    try {
      final items = await remoteDataSource.fetchItems(page);
      return right(items);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Item>>> fetchFavorites() async {
    try {
      final items = await localDataSource.loadFavorites();
      return right(items);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addToFavorites(Item item) async {
    try {
      final itemModel = ItemModel.fromItem(item); // convert Item to ItemModel
      localDataSource.addToFavorites(item: itemModel);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
