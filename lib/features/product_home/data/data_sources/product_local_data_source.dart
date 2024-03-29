import 'dart:developer';

import 'package:tr_store_demo/core/database/product_provider.dart';
import 'package:tr_store_demo/core/error/exceptions.dart';
import 'package:tr_store_demo/features/product_home/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final ProductProvider dbClient;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      await dbClient.insertProducts(products);
    } catch (e) {
      log('insert error: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      List<ProductModel> products = await dbClient.getProducts();
      return products;
    } catch (e) {
      log('local data fetch error: $e');
      throw CacheException();
    }
  }

  ProductLocalDataSourceImpl({
    required this.dbClient,
  });
}
