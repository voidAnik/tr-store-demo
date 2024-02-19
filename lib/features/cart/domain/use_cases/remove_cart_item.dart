import 'package:tr_store_demo/features/cart/domain/repositories/cart_repository.dart';

class RemoveCartItem {
  final CartRepository repository;

  RemoveCartItem(this.repository);

  Future<void> call(int productId) async {
    await repository.removeFromCart(productId);
  }
}
