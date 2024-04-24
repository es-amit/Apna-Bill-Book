import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ListRepository {
  Future<Either<Failure, List<Item>>> fetchItems(int page);

  Future<Either<Failure, List<Item>>> fetchFavorites();

  Future<Either<Failure, Unit>> addToFavorites(Item item);

  Future<Either<Failure, Unit>> removeFromFavorites(int itemKey);
}
