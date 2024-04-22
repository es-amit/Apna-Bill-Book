part of 'item_bloc.dart';

@immutable
sealed class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ItemFetchEvent extends ItemEvent {
  final int page;
  ItemFetchEvent({
    required this.page,
  });
}
