part of 'favorite_bloc.dart';

abstract class FavoriteEvent {
  const FavoriteEvent();
}

class AddFavoriteEvent extends FavoriteEvent {
  final Item item;

  AddFavoriteEvent({
    required this.item,
  });
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final int itemKey;

  RemoveFavoriteEvent({
    required this.itemKey,
  });
}

class FavoriteItemFetchEvent extends FavoriteEvent {
  const FavoriteItemFetchEvent();
}
