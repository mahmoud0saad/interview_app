import 'package:interview_test/features/products/data/datasources/base_products_datasource.dart';
import 'package:interview_test/features/products/data/models/product_model.dart';
import 'package:interview_test/features/products/domain/entities/product.dart';

import '../../../../core/network/api_strings.dart';
import '../../../../core/network/network_interface.dart';

class ProductsDataSource implements BaseProductsDataSource {
  final BaseNetwork network;
  ProductsDataSource({required this.network});
  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await network.get(ApiStrings.getProducts);
      List<ProductModel> products = response.map<ProductModel>((product) => ProductModel.fromJson(product)).toList();
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
