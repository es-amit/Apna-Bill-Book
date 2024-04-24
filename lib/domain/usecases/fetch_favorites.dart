import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:fpdart/fpdart.dart';

class FetchFavorites implements UseCase<List<Item>, NoParams> {
  final ListRepository listRepository;

  FetchFavorites(this.listRepository);

  @override
  Future<Either<Failure, List<Item>>> call(NoParams params) async {
    return await listRepository.fetchFavorites();
  }
}
