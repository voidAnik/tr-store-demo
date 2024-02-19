import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/core/use_cases/use_case.dart';
import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';
import 'package:tr_store_demo/features/cart/domain/repositories/cart_repository.dart';

class GetCartItems extends UseCase<List<Cart>, NoParams> {
  final CartRepository repository;

  GetCartItems(this.repository);

  @override
  Future<Either<Failure, List<Cart>>> call(params) async {
    return await repository.getCarts();
  }
}
