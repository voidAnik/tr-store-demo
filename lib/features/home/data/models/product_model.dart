import 'package:tr_store_demo/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.price,
      required super.title,
      required super.description});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: int.parse(json["id"]),
      price: int.parse(json["userId"]), // using userId as price
      title: json["title"],
      description: json["body"], // using body as description
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "price": price,
      "title": title,
      "description": description,
    };
  }
}
