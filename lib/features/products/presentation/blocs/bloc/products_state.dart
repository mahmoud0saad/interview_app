part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsIntialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<Product> products;
  final int currentPage;
  final SortType   selectedSortType;
  final int?  selectedFilterAlbumId;
  final List<int> allAlbumsId;

   ProductsLoadedState({required this.products,required this.currentPage,required this.allAlbumsId,this.selectedFilterAlbumId,this.selectedSortType=SortType.none});
  @override
  List<Object?> get props => [products,currentPage,allAlbumsId,selectedFilterAlbumId,selectedSortType];
}

class ProductsErrorState extends ProductsState {
  final String message;
  ProductsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
