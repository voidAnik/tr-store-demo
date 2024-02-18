import 'package:tr_store_demo/features/product_home/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.content,
    required super.image,
    required super.thumbnail,
    required super.category,
    required super.publishedAt,
    required super.updatedAt,
    required super.userId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      image: json["image"],
      thumbnail: json["thumbnail"],
      category: json["category"],
      publishedAt: json["publishedAt"],
      updatedAt: json["updatedAt"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "image": image,
      "thumbnail": thumbnail,
      "category": category,
      "publishedAt": publishedAt,
      "updatedAt": updatedAt,
      "userId": userId,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, content: $content, image: $image, thumbnail: $thumbnail, category: $category, publishedAt: $publishedAt, updatedAt: $updatedAt, userId: $userId}';
  }
}
