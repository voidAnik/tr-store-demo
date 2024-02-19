import 'package:equatable/equatable.dart';

import '../../../product_home/data/models/product_model.dart';

class Cart extends Equatable {
  final int productId;
  final int quantity;
  final ProductModel product;

  const Cart({
    required this.quantity,
    required this.productId,
    required this.product,
  });

  Cart copyWith({
    int? productId,
    int? quantity,
    ProductModel? product,
  }) {
    return Cart(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  @override
  List<Object> get props => [productId, quantity, product];
}
