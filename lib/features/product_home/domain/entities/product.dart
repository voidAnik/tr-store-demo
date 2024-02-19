import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.category,
    this.publishedAt,
    this.updatedAt,
    this.userId,
  });

  final int? id;
  final String? title;
  final String? content;
  final String? image;
  final String? thumbnail;
  final String? category;
  final String? publishedAt;
  final String? updatedAt;
  final int? userId;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        image,
        thumbnail,
        category,
        publishedAt,
        updatedAt,
        userId,
      ];
}
