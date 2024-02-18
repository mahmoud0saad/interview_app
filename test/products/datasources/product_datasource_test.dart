import 'package:flutter_test/flutter_test.dart';
import 'package:interview_test/core/network/network_interface.dart';
import 'package:interview_test/features/products/data/datasources/products_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_datasource_test.mocks.dart';

@GenerateMocks([BaseNetwork])
void main() {
  late ProductsDataSource dataSource;
  late MockBaseNetwork mockNetwork;

  setUp(() {
    mockNetwork = MockBaseNetwork();
    dataSource = ProductsDataSource(network: mockNetwork);
  });

  test('getProducts returns a list of products', () async {
    final mockResponse = [
      {'id': 1, 'title': 'Product 1'},
      {'id': 2, 'title': 'Product 2'}
    ]; // Mock response
    when(mockNetwork.get('products')).thenAnswer((_) async => mockResponse);

    final products = await dataSource.getProducts();

    expect(products.length, 2); // Check the length of the returned list
    expect(products[0].id, 1); // Check the id of the first product
    expect(products[0].title, 'Product 1'); // Check the name of the first product
  });

  test('getProducts throws an exception', () async {
    when(mockNetwork.get('products')).thenThrow(Exception('Network error'));

    expect(() async => await dataSource.getProducts(), throwsException);
  });
}
