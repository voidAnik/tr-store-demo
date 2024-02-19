import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tr_store_demo/features/cart/data/models/cart_model.dart';
import 'package:tr_store_demo/features/product_home/data/models/product_model.dart';

const cartTableName = 'cart';
const cartColumnId = 'id';
const cartColumnProductId = 'productId';
const cartColumnQuantity = 'quantity';

class CartProvider {
  final Database _db;

  CartProvider({required Database db}) : _db = db {
    _createCartTable();
  }

  Future<void> _createCartTable() async {
    await _db.execute('''
      CREATE TABLE IF NOT EXISTS $cartTableName (
        $cartColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $cartColumnProductId INTEGER,
        FOREIGN KEY ($cartColumnProductId) REFERENCES product(id)
      );
    ''');
  }

  Future<void> insertProduct(int productId) async {
    // Insert a new product entry without checking for duplicates.
    await _db.insert(
        cartTableName,
        {
          cartColumnProductId: productId,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<CartModel>> getCartItems() async {
    // Join the cart table with the product table to aggregate quantities and fetch product details.
    final List<Map<String, dynamic>> result = await _db.rawQuery('''
      SELECT c.productId, COUNT(c.productId) AS quantity, p.*
      FROM $cartTableName c
      JOIN product p ON c.productId = p.id
      GROUP BY c.productId
    ''');

    return result.map((map) {
      return CartModel(
        productId: map['productId'],
        quantity: map['quantity'],
        product: ProductModel.fromJson(map),
      );
    }).toList();
  }

  Future<void> decrementProductQuantity(int productId) async {
    // Get the first cart entry for the specified product to decrement.
    final List<Map<String, dynamic>> entries = await _db.query(
      cartTableName,
      where: '$cartColumnProductId = ?',
      whereArgs: [productId],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (entries.isNotEmpty) {
      // If an entry exists, delete it to decrement the quantity.
      await _db.delete(
        cartTableName,
        where: 'id = ?',
        whereArgs: [entries.first['id']],
      );
    }
  }

  Future<void> removeAllProductEntries() async {
    // Delete all entries for the specified product.
    await _db.delete(
      cartTableName,
    );
  }

  Future<int> calculateTotalPrice() async {
    final List<Map<String, dynamic>> result = await _db.rawQuery('''
    SELECT SUM(p.userId) AS totalPrice
    FROM $cartTableName c
    JOIN product p ON c.$cartColumnProductId = p.id
  ''');

    if (result.isNotEmpty && result.first["totalPrice"] != null) {
      return int.parse(result.first["totalPrice"].toString());
    } else {
      return 0; // Return 0 if the result is empty or totalPrice is null
    }
  }

  Future<void> close() async => _db.close();
}
