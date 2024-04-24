import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

part 'item_event.dart';
part 'item_state.dart';

const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetAllItems _getAllItems;
  ItemBloc({
    required GetAllItems getAllItems,
  })  : _getAllItems = getAllItems,
        super(const ItemState()) {
    on<ItemFetchEvent>(
      _onFetchAllItems,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  void _onFetchAllItems(
    ItemFetchEvent event,
    Emitter<ItemState> emit,
  ) async {
    try {
      if (event.page > 21) {
        emit(state.copyWith(hasReachedMax: true));
      }
      if (state.status == ItemStatus.initial) {
        final result = await _getAllItems.call(event.page);
        result.fold(
          (l) => emit(state.copyWith(status: ItemStatus.failure)),
          (r) => emit(
            state.copyWith(
              status: ItemStatus.success,
              items: r,
              hasReachedMax:
                  false, // Set hasReachedMax to true if the fetched items are empty
            ),
          ),
        );
      } else if (!state.hasReachedMax) {
        final result = await _getAllItems.call(event.page);
        result.fold(
          (l) => emit(state.copyWith(status: ItemStatus.failure)),
          (r) => emit(
            state.copyWith(
              status: ItemStatus.success,
              items: state.items + r,
              hasReachedMax:
                  false, // Set hasReachedMax to true if the fetched items are empty
            ),
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: ItemStatus.failure));
    }
  }
}
