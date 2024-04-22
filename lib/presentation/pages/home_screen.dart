import 'package:apna_bill_book/core/theme/app_pallete.dart';
import 'package:apna_bill_book/presentation/bloc/item_bloc.dart';
import 'package:apna_bill_book/presentation/widgets/item_card.dart';
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
    _scrollController.addListener(_onScroll);
    context.read<ItemBloc>().add(ItemFetchEvent(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ItemBloc>().add(
            ItemFetchEvent(
              page: page,
            ),
          );

      page++;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ItemDisplaySuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.items.length,
                    itemBuilder: ((context, index) {
                      final item = state.items[index];
                      return ItemCard(
                          item: item,
                          color: index % 3 == 0
                              ? AppPallete.gradient1
                              : index % 3 == 1
                                  ? AppPallete.gradient2
                                  : AppPallete.gradient3);
                    }),
                  ),
                ),
              ],
            );
          } else if (state is ItemLoading) {
            return const Center(
              child: Text('data is loading...'),
            );
          } else if (state is ItemFailure) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
