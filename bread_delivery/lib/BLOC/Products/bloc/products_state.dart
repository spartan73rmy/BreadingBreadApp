part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  ProductsError(this.e);
}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductsForSaleLoaded extends ProductsState {
  final List<ProductSale> products;

  ProductsForSaleLoaded(this.products);
}

class ProductOperationCompleted extends ProductsState {}
