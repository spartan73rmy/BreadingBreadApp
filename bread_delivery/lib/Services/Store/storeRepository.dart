import 'dart:convert';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class StoresLogic {
  Future<List<Store>> fetchStoresList(int idPath);
  Future<void> addStore(String name);
  Future<void> editStore(int id, String name);
  Future<void> deleteStore(int id);
}

class StoreRepository extends StoresLogic {
  static const String url = "Store/";
  DioClient http = DioClient();

  Future<List<Store>> fetchStoresList(int idPath) async {
    final response =
        await http.get(url + "GetList", queryParameters: {'idPath': idPath});
    return Stores.fromJson(response).stores;
  }

  @override
  Future<void> addStore(String name) async {
    try {
      await http.post(url + "Add", data: jsonEncode({'name': name}));
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
}
