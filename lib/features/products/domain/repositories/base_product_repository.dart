import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product.dart';

abstract class BaseProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
