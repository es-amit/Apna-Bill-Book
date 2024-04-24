import 'dart:developer';

import 'package:apna_bill_book/core/theme/app_pallete.dart';
import 'package:apna_bill_book/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:apna_bill_book/presentation/widgets/favorite_card.dart';
import 'package:apna_bill_book/presentation/widgets/lottie_loader.dart';
import 'package:apna_bill_book/presentation/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const FavoriteItemFetchEvent());
  }

  void _removeFavorite(int itemKey) {
    context.read<FavoriteBloc>().add(RemoveFavoriteEvent(itemKey: itemKey));
    showSnackBar(context, 'Item Removed from Favorites!!!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Favorites'),
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteItemFetchState) {
              final favorites = state.items;
              if (favorites.isEmpty) {
                return const Center(
                  child: LottieLoader(
                    image: 'assets/lottie/no_data.json',
                  ),
                );
              }
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return FavoriteCard(
                      item: item,
                      color:
                          index % 2 == 0 ? AppPallete.green : AppPallete.blue,
                      onPressed: () {
                        // delete item
                        _removeFavorite(item.id);
                      });
                },
              );
            } else {
              log(state.toString());
              return const Center(
                child: LottieLoader(
                  image: 'assets/lottie/error.json',
                ),
              );
            }
          },
        ));
  }
}
