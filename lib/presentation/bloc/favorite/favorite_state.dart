part of 'favorite_bloc.dart';

abstract class FavoriteState {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError(this.message);
}

class FavoritedItemState extends FavoriteState {
  const FavoritedItemState();
}

class UnFavoritedItemState extends FavoriteState {
  const UnFavoritedItemState();
}

class FavoriteItemFetchState extends FavoriteState {
  final List<Item> items;

  FavoriteItemFetchState({
    required this.items,
  });
}
