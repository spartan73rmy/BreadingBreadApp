part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryError extends InventoryState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  InventoryError(this.e);
}

class ProductsLoaded extends InventoryState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductOperationCompleted extends InventoryState {}
