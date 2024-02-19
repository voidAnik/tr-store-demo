import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, List<Cart>>> getCarts();
  Future<void> addToCart(int productId);
  Future<void> removeFromCart(int productId);
  Future<void> removeAllFromCart();
  Future<int> getTotalPrice();
}
