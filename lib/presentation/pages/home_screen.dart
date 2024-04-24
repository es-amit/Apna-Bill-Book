import 'dart:developer';

import 'package:apna_bill_book/core/theme/app_pallete.dart';
import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:apna_bill_book/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:apna_bill_book/presentation/bloc/item/item_bloc.dart';
import 'package:apna_bill_book/presentation/pages/favorite_screen.dart';
import 'package:apna_bill_book/presentation/widgets/bottom_loader.dart';
import 'package:apna_bill_book/presentation/widgets/lottie_loader.dart';
import 'package:apna_bill_book/presentation/widgets/item_card.dart';
import 'package:apna_bill_book/presentation/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(ItemFetchEvent(page: page));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && page <= 21) {
      log(page.toString());
      context.read<ItemBloc>().add(ItemFetchEvent(page: page));
    } else {
      page = 1;
    }
  }

  void _onFavorite(Item item) {
    context.read<FavoriteBloc>().add(
          AddFavoriteEvent(item: item),
        );

    showSnackBar(context, 'Item Favorited!!!');
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    page++;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const FavoriteScreen())));
            },
            icon: const Icon(Icons.star),
            color: Colors.yellowAccent,
            iconSize: 40.0,
            tooltip: 'Favourite',
          ),
        ],
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          switch (state.status) {
            case ItemStatus.initial:
              return const Center(
                child: LottieLoader(
                  image: 'assets/lottie/loading_1.json',
                ),
              );
            case ItemStatus.success:
              final items = state.items;
              if (items.isEmpty) {
                return const Center(
                  child: Text('No Items'),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount:
                    state.hasReachedMax ? items.length : items.length + 1,
                itemBuilder: ((context, index) {
                  return index >= items.length
                      ? page <= 21
                          ? const BottomLoader()
                          : const SizedBox()
                      : ItemCard(
                          isFavorite: items[index].isFavorite,
                          onPressed: () => _onFavorite(items[index]),
                          item: items[index],
                          color: index % 3 == 0
                              ? AppPallete.gradient1
                              : index % 3 == 1
                                  ? AppPallete.gradient2
                                  : AppPallete.gradient3,
                        );
                }),
              );
            case ItemStatus.failure:
              return const Center(
                child: LottieLoader(
                  image: 'assets/lottie/error.json',
                ),
              );
          }
        },
      ),
    );
  }
}
