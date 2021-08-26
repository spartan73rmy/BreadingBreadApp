part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetStores extends StoreEvent {
  final int idPath;
  GetStores(this.idPath) : super([idPath]);
}

class AddStore extends StoreEvent {
  final String name;

  AddStore(this.name) : super([name]);
}

class AssignStoreToPath extends StoreEvent {
  final List<Store> stores;
  final int idPath;

  AssignStoreToPath(this.stores, this.idPath) : super([stores, idPath]);
}

class DeallocateStoreToPath extends StoreEvent {
  final int idStore;
  final int idPath;

  DeallocateStoreToPath(this.idStore, this.idPath) : super([idStore, idPath]);
}

class EditStore extends StoreEvent {
  final String name;
  final int id;

  EditStore(this.id, this.name) : super([name, id]);
}

class DeleteStore extends StoreEvent {
  final int id;

  DeleteStore(this.id) : super([id]);
}
