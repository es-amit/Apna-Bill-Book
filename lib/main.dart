import 'package:apna_bill_book/data/datasource/list_remote_data_source.dart';
import 'package:apna_bill_book/data/repositories/list_repository_impl.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:apna_bill_book/presentation/bloc/item_bloc.dart';
import 'package:apna_bill_book/presentation/pages/home_screen.dart';
import 'package:apna_bill_book/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (_) => ItemBloc(
        getAllItems: GetAllItems(
          ListRepositoryImpl(
            ListRemoteDataSourceImpl(),
          ),
        ),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apna Bill Book',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
