import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:fpdart/fpdart.dart';

class RemoveFavorite implements UseCase<List<Item>, int> {
  final ListRepository listRepository;

  RemoveFavorite(this.listRepository);

  @override
  Future<Either<Failure, List<Item>>> call(int itemKey) async {
    return await listRepository.removeFromFavorites(itemKey);
  }
}
