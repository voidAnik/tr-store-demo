import 'dart:async';

import 'package:sqflite/sqflite.dart';

const tableName = 'cart';
const columnId = 'id';
const columnProductId = 'productId';
const columnQuantity = 'quantity';

class CartProvider {
  final Database _db;

  Future<int> insert(int productId, int quantity) async {
    return await _db.insert('Cart', {
      'productId': productId,
      'quantity': quantity,
    });
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    return await _db.rawQuery('''
      SELECT Cart.*, Product.title, Product.price, Product.description
      FROM Cart
      JOIN Product ON Cart.productId = Product.id
    ''');
  }

  Future<int> delete(int id) async {
    return await _db.delete('Cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(int id, int quantity) async {
    return await _db.update('Cart', {'quantity': quantity},
        where: 'id = ?', whereArgs: [id]);
  }

  Future close() async => _db.close();

  CartProvider({
    required Database db,
  }) : _db = db {
    _createTable();
  }

  Future<void> _createTable() async {
    await _db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnProductId INTEGER,
            $columnQuantity INTEGER,
            FOREIGN KEY ($columnProductId) REFERENCES Product(id)
          );
        ''');
  }
}
