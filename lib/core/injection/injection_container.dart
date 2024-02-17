import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tr_store_demo/core/database/cart_provider.dart';
import 'package:tr_store_demo/core/database/database_manager.dart';
import 'package:tr_store_demo/core/database/product_provider.dart';
import 'package:tr_store_demo/core/network/api_client.dart';
import 'package:tr_store_demo/features/home/data/data_sources/home_local_data_source.dart';
import 'package:tr_store_demo/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:tr_store_demo/features/home/data/repositories/home_repository_impl.dart';
import 'package:tr_store_demo/features/home/domain/repositories/home_repository.dart';
import 'package:tr_store_demo/features/home/domain/use_cases/get_products.dart';

import '../utils/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // * Bloc

  // * Use Cases
  getIt.registerLazySingleton(() => GetProducts(getIt()));
  //..registerLazySingleton(() => GetRandomNumberTrivia(getIt()));

  // * Repository
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        localDataSource: getIt(),
        remoteDataSource: getIt(),
        networkInfo: getIt(),
      ));

  // * Data Sources
  getIt
    ..registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSourceImpl(dbClient: getIt()))
    ..registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(
              client: getIt(),
            ));

  // * Core
  getIt
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()))
    ..registerLazySingleton<ApiClient>(() => ApiClient());

  // * Local Database
  final Database db = await DatabaseManager.database;
  // Registering providers with the shared Database instance
  getIt
    ..registerLazySingleton(() => ProductProvider(db: db))
    ..registerLazySingleton(() => CartProvider(db: db));

  // * External
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
