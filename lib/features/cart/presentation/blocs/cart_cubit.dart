import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store_demo/core/blocs/data_state.dart';
import 'package:tr_store_demo/core/constants/app_strings.dart';
import 'package:tr_store_demo/core/error/failures.dart';
import 'package:tr_store_demo/core/use_cases/use_case.dart';
import 'package:tr_store_demo/features/cart/domain/entities/cart.dart';
import 'package:tr_store_demo/features/cart/domain/use_cases/clear_cart.dart';
import 'package:tr_store_demo/features/cart/domain/use_cases/get_cart_items.dart';
import 'package:tr_store_demo/features/cart/domain/use_cases/remove_cart_item.dart';

class CartCubit extends Cubit<DataState> {
  final GetCartItems getCartItems;
  final RemoveCartItem removeCartItem;
  final ClearCart clearCart;
  List<Cart> cartList = [];
  CartCubit(
      {required this.getCartItems,
      required this.removeCartItem,
      required this.clearCart})
      : super(DataLoading());

  Future<void> getCarts() async {
    final Either<Failure, List<Cart>> failureOrResponse =
        await getCartItems(NoParams());
    await Future.delayed(const Duration(milliseconds: 500));
    failureOrResponse.fold((failure) {
      log(
        'get local data failure: $failure',
      );
      if (failure is CacheFailure) {
        emit(const DataError(message: AppStrings.cacheFailure));
      } else {
        emit(const DataError(message: AppStrings.unknownFailure));
      }
    }, (response) {
      cartList.clear();
      cartList.addAll(response);
      emit(DataLoaded<List<Cart>>(response: cartList));
    });
  }

  Future<void> removeCart(Cart cart) async {
    log('removing cart item');
    await removeCartItem(cart.productId);
    List<Cart> updatedCartList = List<Cart>.from(cartList);

    int index =
        updatedCartList.indexWhere((c) => c.productId == cart.productId);
    if (index != -1) {
      if (updatedCartList[index].quantity - 1 > 0) {
        Cart changedItem = updatedCartList[index]
            .copyWith(quantity: updatedCartList[index].quantity - 1);
        updatedCartList[index] = changedItem; // Update the item in the new list
      } else {
        updatedCartList.removeAt(index); // Remove the item from the new list
      }
    }
    cartList = updatedCartList;
    emit(DataLoaded<List<Cart>>(
        response: updatedCartList)); // Emit the new list as the updated state
  }

  Future<void> clearCartItems() async {
    log('removing cart items');
    await clearCart();
    List<Cart> newCarts = List.from(cartList);
    newCarts.clear();
    cartList = newCarts;
    await Future.delayed(const Duration(seconds: 1));
    emit(DataLoaded<List<Cart>>(response: newCarts));
  }
}
