part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
 final SortType  sortType;
 final PaginateType  paginateType;
 final int?  albumId;
  const ProductsEvent({this.sortType=SortType.none,this.paginateType=PaginateType.inital,this.albumId,});

  @override
  List<Object?> get props => [albumId,sortType,paginateType];
}

class LoadProductsEvent extends ProductsEvent {}
class SortProductsEvent extends ProductsEvent {
  final SortType  sortType;

  const SortProductsEvent({required this.sortType}):super(sortType:sortType);
}
class PaginationProductsEvent extends ProductsEvent {
  final PaginateType  paginateType;

  const PaginationProductsEvent({required this.paginateType}):super(paginateType:paginateType);
}
class FilterByAlbumIdEvent extends ProductsEvent {
  final int?  albumId;

  const FilterByAlbumIdEvent({required this.albumId}):super(albumId:albumId);
}

