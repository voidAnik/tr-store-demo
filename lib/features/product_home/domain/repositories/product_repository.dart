import 'package:dartz/dartz.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
