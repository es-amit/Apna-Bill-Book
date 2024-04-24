import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:fpdart/fpdart.dart';

class AddFavorite implements UseCase<Unit, Item> {
  final ListRepository listRepository;

  AddFavorite(this.listRepository);

  @override
  Future<Either<Failure, Unit>> call(Item item) {
    return listRepository.addToFavorites(item);
  }
}
