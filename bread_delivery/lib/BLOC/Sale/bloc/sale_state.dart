part of 'sale_bloc.dart';

abstract class SaleState extends Equatable {
  const SaleState();

  @override
  List<Object> get props => [];
}

class SaleInitial extends SaleState {}

class SaleLoading extends SaleState {}

class SaleError extends SaleState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  SaleError(this.e);
}

class ProductsForSaleLoaded extends SaleState {
  final List<ProductSale> products;

  ProductsForSaleLoaded(this.products);
}

class SaleOperationCompleted extends SaleState {}
