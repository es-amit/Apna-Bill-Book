part of 'item_bloc.dart';

enum ItemStatus { initial, success, failure }

final class ItemState extends Equatable {
  final ItemStatus status;
  final List<Item> items;
  final bool hasReachedMax;

  const ItemState({
    this.status = ItemStatus.initial,
    this.items = const <Item>[],
    this.hasReachedMax = false,
  });

  ItemState copyWith({
    ItemStatus? status,
    List<Item>? items,
    bool? hasReachedMax,
  }) {
    return ItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, items, hasReachedMax];
}
