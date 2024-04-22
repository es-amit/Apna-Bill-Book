import 'package:apna_bill_book/core/error/exceptions.dart';
import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/data/datasource/list_remote_data_source.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:fpdart/fpdart.dart';

class ListRepositoryImpl implements ListRepository {
  final ListRemoteDataSource remoteDataSource;

  ListRepositoryImpl(this.remoteDataSource);

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
}
