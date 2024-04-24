import 'package:apna_bill_book/presentation/bloc/favorite/favorite_bloc.dart';
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
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("${item.category} - ${item.price}"),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No Favorites'),
              );
            }
          },
        ));
  }
}
