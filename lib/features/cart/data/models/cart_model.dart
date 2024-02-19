import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';
import 'package:tr_store_demo/features/product_home/data/models/product_model.dart';

class CartModel extends Cart {
  CartModel(
      {required super.productId,
      required super.quantity,
      required super.product});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      quantity: int.parse(json["quantity"]),
      productId: int.parse(json["productId"]),
      product: ProductModel.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "productId": productId,
      "product": product.toJson(),
    };
  }

  @override
  String toString() {
    return 'quantity: $quantity, productId: $productId, product: $product}';
  }
}
