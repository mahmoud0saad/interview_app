import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecase/base_usecase.dart';
import '../../../../../core/utils/enums/PaginateType.dart';
import '../../../../../core/utils/enums/SortType.dart';
import '../../../domain/entities/product.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final BaseUseCase productsUseCase;
    List<Product>? allProducts;
    List<Product>? allProductsFromApi;
    int  _currentPage=1;

  SortType?  selectedSortType;
    int?  selectedFilterAlbumId;
    List<int>? allAlbumsId;

    final int  _productPerPage=10;

  ProductsBloc({required this.productsUseCase}) : super(ProductsIntialState()) {
    /// on load all product forom api
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductsLoadingState());
      final result = await productsUseCase(const NoParams());
      result.fold((error) {
        emit(ProductsErrorState(message: error.message));
      }, (products) {
        allProductsFromApi=products;
        allProducts=products;
        allAlbumsId=getUniqueAlbumIds(products);

        /// get first 10 item form list
        List<Product> result =paginatedProduct(products,PaginateType.inital);
        emit(ProductsLoadedState(products: result,currentPage: _currentPage,allAlbumsId: allAlbumsId??[]));
      });
    });

    /// on user click to sort product
    on<SortProductsEvent>((event, emit) async {
      emit(ProductsLoadingState());
      selectedSortType=event.sortType;
      List<Product> resultSort =sortProduct(allProducts??[], event.sortType);
      allProducts=resultSort;

      List<Product> result =paginatedProduct( resultSort,PaginateType.inital);
      log("mano result ${result.first.title}");

      emit(ProductsLoadedState(products: result,currentPage: _currentPage,allAlbumsId: allAlbumsId??[],selectedSortType:event.sortType));
    });

    /// on user click to filter by album id
    on<FilterByAlbumIdEvent>((event, emit) async {
      emit(ProductsLoadingState());
      selectedFilterAlbumId=event.albumId;
      List<Product> resultFilter =filterProductByAlbumId(allProducts??[], event.albumId);
      allProducts=resultFilter;
      List<Product> result =paginatedProduct( resultFilter,PaginateType.inital);

      emit(ProductsLoadedState(products: result,currentPage: _currentPage,allAlbumsId: allAlbumsId??[],selectedSortType:event.sortType));
    });

    /// on user click to change page next or previous
    on<PaginationProductsEvent>((event, emit) async {
      emit(ProductsLoadingState());

      List<Product> result =paginatedProduct(allProducts??[],event.paginateType);
      emit(ProductsLoadedState(products: result,currentPage: _currentPage,allAlbumsId: allAlbumsId??[],selectedSortType:selectedSortType??SortType.none));
    });
  }

  /// sort photo depend on sort type
  List<Product> sortProduct(List<Product> product, SortType sortType) {


    product.sort((a, b) {
      if (sortType == SortType.albumId) {
        return a.albumId?.compareTo(b?.albumId ?? 0) ?? 0;
      } else if (sortType == SortType.none) {
        return a.albumId?.compareTo(b?.albumId ?? 0) ?? 0;
      } else if (sortType == SortType.title) {
        return a.title?.compareTo(b?.title ?? "") ?? 0;
      }
      return 0;
    });

    return product;
  }


  /// calculate logic for increase or decrease and get all product
  List<Product> paginatedProduct(List<Product> allProdcut,PaginateType paginateType) {
    switch (paginateType){

      case PaginateType.inital:
        _currentPage=1;

        break;
      case PaginateType.increase:
        if (_currentPage > 1) {
          _currentPage--;
        }
        break;
      case PaginateType.decrease:
        if ((_currentPage * _productPerPage) < (allProducts?.length??0)) {
          _currentPage++;
        }
        break;
    }


    return getPaginatedProduct(allProdcut);
  }


  /// Method for getting paginated photos for the current page
  List<Product> getPaginatedProduct(List<Product> allProdcut) {
    final int startIndex = (_currentPage - 1) * _productPerPage;
    final int endIndex = startIndex + _productPerPage;
      /// get limit list from startIndex  to endIndex if all product don't empty
      return allProdcut .sublist(startIndex, endIndex < allProdcut .length ? endIndex : allProducts!.length)??[];
  }


  /// Method for getting unique album IDs from the product list
  List<int> getUniqueAlbumIds(List<Product> prodcut) {
    // Use a Set to automatically remove duplicate album IDs
    Set<int> uniqueAlbumIdsSet = Set<int>();

    for (var item in prodcut) {
        uniqueAlbumIdsSet.add(item.albumId??0);
    }

    // Convert the Set back to a List
    List<int> uniqueAlbumIds = uniqueAlbumIdsSet.toList();

    return uniqueAlbumIds;
  }

  /// Method for filtering products by album ID
  List<Product> filterProductByAlbumId(List<Product> product, int? albumId) {
    if(albumId==null){
      return allProductsFromApi??[];
    }

    return product.where((element) => element.albumId==albumId).toList()??[];

  }

}

