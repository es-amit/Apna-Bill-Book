import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetAllItems _getAllItems;
  ItemBloc({
    required GetAllItems getAllItems,
  })  : _getAllItems = getAllItems,
        super(ItemInitial()) {
    on<ItemEvent>(
      (event, emit) => emit(
        ItemLoading(),
      ),
    );

    on<ItemFetchEvent>(_onFetchAllItems);
  }

  void _onFetchAllItems(
    ItemFetchEvent event,
    Emitter<ItemState> emit,
  ) async {
    final result = await _getAllItems(event.page);

    result.fold(
      (l) => emit(ItemFailure(l.message)),
      (r) {
        if (state is ItemDisplaySuccess) {
          final oldItems = (state as ItemDisplaySuccess).items;
          final allItems = List.of(oldItems)..addAll(r);
          emit(ItemDisplaySuccess(allItems));
        } else {
          emit(ItemDisplaySuccess(r));
        }
      },
    );
  }
}
