import 'package:interview_test/features/products/domain/entities/product.dart';

abstract class BaseProductsDataSource {
  Future<List<Product>> getProducts();
}
