import 'package:equatable/equatable.dart';
import 'package:interview_test/features/products/domain/entities/rating.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;


  const Product({required this.albumId, required this.id, required this.title, required this.url,required  this.thumbnailUrl});



  @override
  List<Object?> get props => [ albumId, id, title, url, thumbnailUrl];
}
