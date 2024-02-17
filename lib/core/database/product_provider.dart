import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tr_store_demo/features/home/data/models/product_model.dart';

const tableName = 'product';
const columnId = 'id';
const columnTitle = 'title';
const columnContent = 'content';
const columnImage = 'image';
const columnThumbnail = 'thumbnail';
const columnCategory = 'category';
const columnPublishedAt = 'publishedAt';
const columnUpdatedAt = 'updatedAt';
const columnUserId = 'userId';

class ProductProvider {
  final Database _db;

  ProductProvider({required Database db}) : _db = db {
    _createTable();
  }

  FutureOr<void> _createTable() async {
    await _db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT,
            $columnContent TEXT,
            $columnImage TEXT,
            $columnThumbnail TEXT,
            $columnCategory TEXT,
            $columnPublishedAt TEXT,
            $columnUpdatedAt TEXT,
            $columnUserId INTEGER
          );
        ''');
  }

  Future<void> insert(ProductModel product) async {
    await _db.insert(tableName, product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProducts(List<ProductModel> products) async {
    await _db.transaction((txn) async {
      for (var product in products) {
        await txn.insert(tableName, product.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<List<ProductModel>> getProducts() async {
    final List<Map<String, dynamic>> maps = await _db.query(tableName);
    return maps.map((map) => ProductModel.fromJson(map)).toList();
  }

  Future<ProductModel?> getProduct(int id) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      tableName,
      columns: [
        columnId,
        columnTitle,
        columnContent,
        columnImage,
        columnThumbnail,
        columnCategory,
        columnPublishedAt,
        columnUpdatedAt,
        columnUserId
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(ProductModel product) async {
    return await _db.update(tableName, product.toJson(),
        where: '$columnId = ?', whereArgs: [product.id]);
  }

  Future close() async => _db.close();
}
