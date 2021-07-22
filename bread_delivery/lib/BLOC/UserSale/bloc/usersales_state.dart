part of 'usersales_bloc.dart';

abstract class UserSalesState extends Equatable {
  const UserSalesState();

  @override
  List<Object> get props => [];
}

class UserSalesInitial extends UserSalesState {}

class UserSalesLoading extends UserSalesState {}

class UserSalesError extends UserSalesState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  UserSalesError(this.e);
}

class UserSalesLoaded extends UserSalesState {
  final List<Path> paths;

  UserSalesLoaded(this.paths);
}

class UserSaleAssigned extends UserSalesState {}

class UserSalesOperationCompleted extends UserSalesState {}
