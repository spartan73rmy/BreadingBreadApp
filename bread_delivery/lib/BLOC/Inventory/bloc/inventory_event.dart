part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent(props);

  @override
  List<Object> get props => [];
}

class AddInventoryProducts extends InventoryEvent {
  final List<Product> products;
  final ActivePath activePath;
  final String btMAC;

  AddInventoryProducts(this.products, this.activePath, this.btMAC)
      : super([products, activePath, btMAC]);
}

class GetProducts extends InventoryEvent {
  GetProducts() : super([]);
}
