import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:tr_store_demo/features/product_home/data/models/product_model.dart';

const tableName = 'product';
const productColumnId = 'id';
const productColumnTitle = 'title';
const productColumnContent = 'content';
const productColumnImage = 'image';
const productColumnThumbnail = 'thumbnail';
const productColumnCategory = 'category';
const productColumnPublishedAt = 'publishedAt';
const productColumnUpdatedAt = 'updatedAt';
const productColumnUserId = 'userId';

class ProductProvider {
  final Database _db;

  ProductProvider({required Database db}) : _db = db {
    _createTable();
  }

  FutureOr<void> _createTable() async {
    await _db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            $productColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $productColumnTitle TEXT,
            $productColumnContent TEXT,
            $productColumnImage TEXT,
            $productColumnThumbnail TEXT,
            $productColumnCategory TEXT,
            $productColumnPublishedAt TEXT,
            $productColumnUpdatedAt TEXT,
            $productColumnUserId INTEGER
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
        productColumnId,
        productColumnTitle,
        productColumnContent,
        productColumnImage,
        productColumnThumbnail,
        productColumnCategory,
        productColumnPublishedAt,
        productColumnUpdatedAt,
        productColumnUserId
      ],
      where: '$productColumnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _db
        .delete(tableName, where: '$productColumnId = ?', whereArgs: [id]);
  }

  Future<int> update(ProductModel product) async {
    return await _db.update(tableName, product.toJson(),
        where: '$productColumnId = ?', whereArgs: [product.id]);
  }

  Future close() async => _db.close();
}
