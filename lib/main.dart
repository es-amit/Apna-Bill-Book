import 'package:apna_bill_book/init_dependencies.dart';
import 'package:apna_bill_book/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:apna_bill_book/presentation/bloc/item/item_bloc.dart';
import 'package:apna_bill_book/presentation/pages/home_screen.dart';
import 'package:apna_bill_book/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Bloc.observer = const SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(
          create: (_) => serviceLocator<ItemBloc>(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (_) => serviceLocator<FavoriteBloc>(),
        )
      ],
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
