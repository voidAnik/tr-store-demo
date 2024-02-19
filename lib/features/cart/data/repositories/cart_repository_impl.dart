import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/exceptions.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';
import 'package:tr_store_demo/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource localDataSource;

  @override
  Future<void> addToCart(int productId) async {
    await localDataSource.addToCart(productId);
  }

  @override
  Future<Either<Failure, List<Cart>>> getCarts() async {
    try {
      final products = await localDataSource.getCarts();
      return Right(products);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> removeAllFromCart() async {
    await localDataSource.removeAllFromCart();
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await localDataSource.removeFromCart(productId);
  }

  CartRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<int> getTotalPrice() async {
    return await localDataSource.getTotalPrice();
  }
}
