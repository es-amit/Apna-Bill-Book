import 'package:fpdart/fpdart.dart';

import 'package:apna_bill_book/core/error/failures.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}

class GetAllItems implements UseCase<List<Item>, int> {
  final ListRepository listRepository;

  GetAllItems(this.listRepository);

  @override
  Future<Either<Failure, List<Item>>> call(int page) async {
    return await listRepository.fetchItems(page);
  }
}
