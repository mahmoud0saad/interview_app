import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dartz/dartz.dart';
import 'package:interview_test/core/errors/failure.dart';
import 'package:interview_test/core/usecase/base_usecase.dart';
import 'package:interview_test/features/products/domain/usecases/get_products_usecase.dart';
import 'package:interview_test/features/products/presentation/blocs/bloc/products_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/products_mocks.dart';
import 'products_bloc_test.mocks.dart';

@GenerateMocks([GetProductsUsecase])
void main() {
  late ProductsBloc bloc;
  late MockGetProductsUsecase mockUseCase;

  setUp(() {
    mockUseCase = MockGetProductsUsecase();
    bloc = ProductsBloc(productsUseCase: mockUseCase);
  });

  test('initial state is ProductsInitialState', () {
    expect(bloc.state, ProductsIntialState());
  });

  blocTest<ProductsBloc, ProductsState>(
    'emits [ProductsLoadingState, ProductsLoadedState] when LoadProductsEvent is added',
    build: () {
      when(mockUseCase(const NoParams())).thenAnswer((_) async => Right(mockProducts));
      return ProductsBloc(productsUseCase: mockUseCase);
    },
    act: (bloc) => bloc.add(LoadProductsEvent()),
    expect: () => [ProductsLoadingState(), ProductsLoadedState(products: mockProducts, currentPage: 1, allAlbumsId: [])],
  );

  blocTest<ProductsBloc, ProductsState>(
    'emits [ProductsLoadingState, ProductsErrorState] when LoadProductsEvent is added and use case fails',
    build: () {
      final mockFailure = ServerFailure(message: 'Server error');
      when(mockUseCase(const NoParams())).thenAnswer((_) async => Left(mockFailure));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadProductsEvent()),
    expect: () => [ProductsLoadingState(), ProductsErrorState(message: 'Server error')],
  );
}
