import 'dart:convert';

import 'package:bread_delivery/Entities/path.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class PathsLogic {
  Future<List<Path>> fetchPathsList();
  Future<void> addPath(String name);
  Future<void> editPath(int id, String name);
  Future<void> deletePath(int id);
}

class PathRepository extends PathsLogic {
  static const String url = "Path/";
  DioClient http = DioClient();

  Future<List<Path>> fetchPathsList() async {
    final response = await http.get(url + "GetList");
    return Paths.fromJson(response).paths;
  }

  @override
  Future<void> addPath(String name) async {
    try {
      await http.post(url + "Add", data: jsonEncode({'name': name}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> editPath(int id, String name) async {
    try {
      await http.post(url + "Edit", data: jsonEncode({'id': id, 'name': name}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deletePath(int id) async {
    try {
      await http.post(url + "Delete", data: jsonEncode({'id': id}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
