import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/exceptions.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/core/utils/network_info.dart';
import 'package:tr_store_demo/features/home/data/data_sources/home_local_data_source.dart';
import 'package:tr_store_demo/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:tr_store_demo/features/home/domain/entities/product.dart';
import 'package:tr_store_demo/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProducts();
        localDataSource.cacheProducts(products);
        return Right(products);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final products = await localDataSource.getProducts();
        return Right(products);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
