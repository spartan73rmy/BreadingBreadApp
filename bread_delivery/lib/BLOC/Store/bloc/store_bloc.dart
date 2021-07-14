import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Store/storeRepository.dart';
import 'package:equatable/equatable.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoresLogic logic;
  StoreBloc(this.logic) : super(StoreInitial());

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is GetStores) {
      yield StoreLoading();
      try {
        var stores = await logic.fetchStoresList(event.idPath);
        if (stores != null) {
          yield StoresLoaded(stores);
        }
        yield StoresLoaded(<Store>[]);
      } catch (e) {
        if (e is MyException && e != null) yield StoreError(e);
        yield StoresLoaded(<Store>[]);
      }
    }

    if (event is AddStore) {
      yield StoreLoading();
      try {
        await logic.addStore(1, event.name);
        yield StoreOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield StoreError(e);
        yield StoresLoaded(<Store>[]);
      }
    }
    if (event is EditStore) {
      yield StoreLoading();
      try {
        await logic.editStore(event.id, event.name);
        yield StoreOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield StoreError(e);
        yield StoresLoaded(<Store>[]);
      }
    }

    if (event is DeleteStore) {
      yield StoreLoading();
      try {
        await logic.deleteStore(event.id);
        yield StoreOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield StoreError(e);
        yield StoresLoaded(<Store>[]);
      }
    }
  }
}
