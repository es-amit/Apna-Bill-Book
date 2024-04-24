import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:fpdart/fpdart.dart';

class RemoveFavorite implements UseCase<Unit, int> {
  final ListRepository listRepository;

  RemoveFavorite(this.listRepository);

  @override
  Future<Either<Failure, Unit>> call(int itemKey) {
    return listRepository.removeFromFavorites(itemKey);
  }
}
