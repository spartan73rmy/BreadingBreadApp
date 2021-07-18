part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent {
  GetProducts() : super([]);
}

class AddProduct extends ProductsEvent {
  final String name;
  final double price;

  AddProduct(this.name, this.price) : super([name, price]);
}

class EditProduct extends ProductsEvent {
  final String name;
  final double price;
  final int id;

  EditProduct(this.id, this.name, this.price) : super([name, id, price]);
}

class DeleteProduct extends ProductsEvent {
  final int id;

  DeleteProduct(this.id) : super([id]);
}
