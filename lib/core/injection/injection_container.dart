import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tr_store_demo/core/database/cart_provider.dart';
import 'package:tr_store_demo/core/database/database_manager.dart';
import 'package:tr_store_demo/core/database/product_provider.dart';
import 'package:tr_store_demo/core/network/api_client.dart';
import 'package:tr_store_demo/features/product_home/data/data_sources/product_local_data_source.dart';
import 'package:tr_store_demo/features/product_home/data/data_sources/product_remote_data_source.dart';
import 'package:tr_store_demo/features/product_home/data/repositories/product_repository_impl.dart';
import 'package:tr_store_demo/features/product_home/domain/repositories/product_repository.dart';
import 'package:tr_store_demo/features/product_home/domain/use_cases/get_products.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/products_cubit.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/quantity_cubit.dart';
import 'package:tr_store_demo/features/product_home/presentation/blocs/total_money_cubit.dart';

import '../utils/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // * Bloc
  getIt.registerFactory(() => ProductsCubit(getProducts: getIt()));
  getIt.registerFactory(() => QuantityCubit());
  getIt.registerLazySingleton(() => TotalMoneyCubit());
  // * Use Cases
  getIt.registerLazySingleton(() => GetProducts(getIt()));

  // * Repository
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        localDataSource: getIt(),
        remoteDataSource: getIt(),
        networkInfo: getIt(),
      ));

  // * Data Sources
  getIt
    ..registerLazySingleton<ProductLocalDataSource>(
        () => ProductLocalDataSourceImpl(dbClient: getIt()))
    ..registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(
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
