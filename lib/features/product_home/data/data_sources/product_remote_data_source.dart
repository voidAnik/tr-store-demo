import 'package:tr_store_demo/core/constants/api_url.dart';
import 'package:tr_store_demo/core/network/api_client.dart';
import 'package:tr_store_demo/core/network/return_response.dart';
import 'package:tr_store_demo/features/product_home/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiClient client;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.dio.get(ApiUrl.getProducts);
    return ReturnResponse<List<ProductModel>>()(response,
        (data) => (data as List).map((e) => ProductModel.fromJson(e)).toList());
  }

  ProductRemoteDataSourceImpl({
    required this.client,
  });
}
