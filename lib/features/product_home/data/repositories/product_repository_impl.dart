import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/exceptions.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/core/utils/network_info.dart';
import 'package:tr_store_demo/features/product_home/data/data_sources/product_local_data_source.dart';
import 'package:tr_store_demo/features/product_home/data/data_sources/product_remote_data_source.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
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
