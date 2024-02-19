import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store_demo/features/cart/domain/repositories/cart_repository.dart';
import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';

class CartTotalCubit extends Cubit<int> {
  final CartRepository repository;
  CartTotalCubit({required this.repository}) : super(0);

  Future<void> addToCart(Product product) async {
    await repository.addToCart(product.id!);
    emit(state + product.userId!);
  }

  Future<void> loadTotalPrice() async {
    int totalPrice = await repository.getTotalPrice();
    log('total price local: $totalPrice');
    emit(totalPrice);
  }

  void clearValue() {
    emit(0);
  }

  void removeFromCart(int value) {
    emit(state - value);
  }
}
