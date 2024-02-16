import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  // userId as price
  final int price;
  final String title;
  // body as description
  final String description;

  const Product({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, price, title, description];
}
