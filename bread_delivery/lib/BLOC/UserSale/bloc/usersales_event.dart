part of 'usersales_bloc.dart';

abstract class UserSalesEvent extends Equatable {
  const UserSalesEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetUserSales extends UserSalesEvent {
  GetUserSales() : super([]);
}

class AddUserSale extends UserSalesEvent {
  final int idPath;

  AddUserSale(this.idPath) : super([idPath]);
}

class DeleteUserSale extends UserSalesEvent {
  final int id;

  DeleteUserSale(this.id) : super([id]);
}
