part of 'sale_bloc.dart';

abstract class SaleEvent extends Equatable {
  const SaleEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetProductForSale extends SaleEvent {
  GetProductForSale() : super([]);
}

class AddSale extends SaleEvent {
  Sale sale;

  AddSale(this.sale) : super([sale]);
}
