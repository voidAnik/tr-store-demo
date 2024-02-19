import 'dart:developer';

import 'package:tr_store_demo/core/database/cart_provider.dart';
import 'package:tr_store_demo/core/error/exceptions.dart';
import 'package:tr_store_demo/features/cart/data/models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartModel>> getCarts();

  Future<void> addToCart(int productId);

  Future<void> removeFromCart(int productId);

  Future<void> removeAllFromCart();
  Future<int> getTotalPrice();
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  final CartProvider dbClient;

  @override
  Future<void> addToCart(int productId) async {
    try {
      dbClient.insertProduct(productId);
    } catch (e) {
      log('insert error: $e');
    }
  }

  @override
  Future<List<CartModel>> getCarts() async {
    try {
      List<CartModel> cartItems = await dbClient.getCartItems();
      return cartItems;
    } catch (e) {
      log('local data fetch error: $e');
      throw CacheException();
    }
  }

  @override
  Future<void> removeAllFromCart() async {
    try {
      await dbClient.removeAllProductEntries();
    } catch (e) {
      log('remove product error: $e');
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      await dbClient.decrementProductQuantity(productId);
    } catch (e) {
      log('decrement error: $e');
    }
  }

  CartLocalDataSourceImpl({
    required this.dbClient,
  });

  @override
  Future<int> getTotalPrice() async {
    try {
      int totalPrice = await dbClient.calculateTotalPrice();
      return totalPrice;
    } catch (e) {
      log('total Price data fetch error: $e');
      throw CacheException();
    }
  }
}
