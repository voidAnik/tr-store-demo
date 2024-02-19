import 'package:tr_store_demo/features/cart/domain/repositories/cart_repository.dart';

class ClearCart {
  final CartRepository repository;

  ClearCart(this.repository);

  Future<void> call() async {
    await repository.removeAllFromCart();
  }
}
