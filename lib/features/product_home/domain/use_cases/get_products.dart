import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/core/use_cases/use_case.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';
import 'package:tr_store_demo/features/product_home/domain/repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
