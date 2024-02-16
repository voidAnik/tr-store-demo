import 'package:tr_store_demo/features/home/data/models/product_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}
