import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:interview_test/core/usecase/base_usecase.dart';

import 'core/network/dio_helper.dart';
import 'core/network/network_interface.dart';
import 'features/products/data/datasources/base_products_datasource.dart';
import 'features/products/data/datasources/products_datasource.dart';
import 'features/products/data/repositories/products_repository.dart';
import 'features/products/domain/repositories/base_product_repository.dart';
import 'features/products/domain/usecases/get_products_usecase.dart';
import 'features/products/presentation/blocs/bloc/products_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ProductsBloc(productsUseCase: sl()));

  // Usecases
  sl.registerLazySingleton<BaseUseCase>(() => GetProductsUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<BaseProductRepository>(() => ProductsRepository(productsDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<BaseProductsDataSource>(() => ProductsDataSource(network: sl()));

  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<BaseNetwork>(() => DioHelper(dio: sl()));
}
