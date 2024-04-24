// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/domain/usecases/add_to_favorite.dart';
import 'package:apna_bill_book/domain/usecases/fetch_favorites.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final AddFavorite addFavorite;
  final FetchFavorites fetchFavorites;

  FavoriteBloc({
    required this.addFavorite,
    required this.fetchFavorites,
  }) : super(const FavoriteInitial()) {
    on<AddFavoriteEvent>(_onAddFavoriteItem);

    on<FavoriteItemFetchEvent>(_onFetchItem);
  }

  void _onAddFavoriteItem(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final result = await addFavorite.call(event.item);
      result.fold(
        (failure) =>
            emit(const FavoriteError('Failed to add item to favorites')),
        (unit) => emit(const FavoritedItemState()),
      );
    } catch (e) {
      emit(const FavoriteError('Failed to add item to favorites'));
    }
  }

  void _onFetchItem(
    FavoriteItemFetchEvent event,
    Emitter<FavoriteState> state,
  ) async {
    try {
      final result = await fetchFavorites.call(NoParams());
      result.fold(
        (l) => emit(const FavoriteError('Failed to fetch favorite items')),
        (r) => emit(FavoriteItemFetchState(items: r)),
      );
    } catch (e) {
      emit(const FavoriteError('Failed to fetch favorite items'));
    }
  }
}
