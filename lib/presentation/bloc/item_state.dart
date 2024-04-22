part of 'item_bloc.dart';

sealed class ItemState {
  const ItemState();
}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemFailure extends ItemState {
  final String error;
  ItemFailure(this.error);
}

final class ItemDisplaySuccess extends ItemState {
  final List<Item> items;
  ItemDisplaySuccess(this.items);
}
