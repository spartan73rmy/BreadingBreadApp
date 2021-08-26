part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreError extends StoreState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  StoreError(this.e);
}

class StoresLoaded extends StoreState {
  final List<Store> stores;
  final List<Store> storesAvailable;

  StoresLoaded(this.stores, this.storesAvailable);
}

class StoreOperationCompleted extends StoreState {}
