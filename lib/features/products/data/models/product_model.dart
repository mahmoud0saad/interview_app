import 'package:interview_test/features/products/domain/entities/product.dart';


// ignore: must_be_immutable
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    super.title,
    super.thumbnailUrl,
    required super.albumId,
    super.url,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      albumId: json['albumId'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
