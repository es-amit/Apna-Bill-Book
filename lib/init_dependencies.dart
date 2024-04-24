import 'package:apna_bill_book/data/datasource/list_local_data_source.dart';
import 'package:apna_bill_book/data/datasource/list_remote_data_source.dart';
import 'package:apna_bill_book/data/repositories/list_repository_impl.dart';
import 'package:apna_bill_book/domain/repositories/list_repository.dart';
import 'package:apna_bill_book/domain/usecases/add_to_favorite.dart';
import 'package:apna_bill_book/domain/usecases/fetch_favorites.dart';
import 'package:apna_bill_book/domain/usecases/get_all_items.dart';
import 'package:apna_bill_book/domain/usecases/remove_favorite.dart';
import 'package:apna_bill_book/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:apna_bill_book/presentation/bloc/item/item_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initItem();

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'favorites'),
  );
}

void _initItem() {
  serviceLocator
    ..registerFactory<ListRemoteDataSource>(
      () => ListRemoteDataSourceImpl(),
    )
    ..registerFactory<ListRepository>(
      () => ListRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllItems(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => AddFavorite(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchFavorites(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RemoveFavorite(
        serviceLocator(),
      ),
    )
    ..registerFactory<ItemsLocalDataSource>(
      () => ItemsLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ItemBloc(
        getAllItems: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FavoriteBloc(
        addFavorite: serviceLocator(),
        fetchFavorites: serviceLocator(),
        removeFavorite: serviceLocator(),
      ),
    );
}
