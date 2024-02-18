import 'package:dartz/dartz.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/base_product_repository.dart';
import '../datasources/base_products_datasource.dart';

class ProductsRepository implements BaseProductRepository {
  final BaseProductsDataSource productsDataSource;
  ProductsRepository({required this.productsDataSource});
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await productsDataSource.getProducts();
      return Right(products);
    } on SereverException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AppTimeoutException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } catch (e) {
      return const Left(ServerFailure(message: 'unexpected error occured'));
    }
  }
}
