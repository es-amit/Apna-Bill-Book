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
  final Item item;

  RemoveFavoriteEvent({
    required this.item,
  });
}

class FavoriteItemFetchEvent extends FavoriteEvent {
  const FavoriteItemFetchEvent();
}
