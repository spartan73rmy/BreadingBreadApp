import 'dart:convert';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class StoresLogic {
  Future<List<Store>> fetchStoresList();
  Future<List<Store>> fetchStoresListByPath(int idPath);
  Future<void> addStore(int idPath, String name);
  Future<void> editStore(int id, String name);
  Future<void> deleteStore(int id);
  Future<void> assignStoresToPath(List<Store> idStores, int idPath);
  Future<void> deallocateStoreFromPath(int idStore, int idPath);
}

class StoreRepository extends StoresLogic {
  static const String url = "Store/";
  DioClient http = DioClient();

  @override
  Future<List<Store>> fetchStoresList() async {
    final response = await http.get(url + "GetList");
    return Stores.fromJson(response).stores;
  }

  @override
  Future<List<Store>> fetchStoresListByPath(int idPath) async {
    final response = await http
        .get(url + "GetListByPath", queryParameters: {'idPath': idPath});
    return Stores.fromJson(response).stores;
  }

  @override
  Future<void> addStore(int idPath, String name) async {
    try {
      await http.post(url + "Add",
          data: jsonEncode({'idPath': idPath, 'name': name}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> editStore(int id, String name) async {
    try {
      await http.post(url + "Edit", data: jsonEncode({'id': id, 'name': name}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deleteStore(int id) async {
    try {
      await http.post(url + "Delete", data: jsonEncode({'id': id}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> assignStoresToPath(List<Store> idStores, int idPath) async {
    try {
      List<int> ids = idStores.map((e) => e.id).toList();
      await http.post(url + "Assign",
          data: jsonEncode({'idPath': idPath, 'IdStores': ids}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deallocateStoreFromPath(int idStore, int idPath) async {
    try {
      await http.post(url + "Deallocate",
          data: jsonEncode({'idPath': idPath, 'idStore': idStore}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
