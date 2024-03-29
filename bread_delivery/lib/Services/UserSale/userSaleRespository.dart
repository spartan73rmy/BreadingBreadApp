import 'dart:convert';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:bread_delivery/Entities/userSaleId.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class UserSalesLogic {
  Future<Path> getSelectedPath();
  Future<List<Path>> fetchPathsList();
  Future<int> addUserSale(int idPath, int idUser);
  Future<void> deleteUserSale(int id);
  Future<List<ActivePath>> getActivePaths();
}

class UserSalesRepository extends UserSalesLogic {
  static const String url = "UserSale/";
  static const String urlPath = "Path/";
  DioClient http = DioClient();

  @override
  Future<List<Path>> fetchPathsList() async {
    final response = await http.get(urlPath + "GetList");
    return Paths.fromJson(response).paths;
  }

  @override
  Future<int> addUserSale(int idPath, int idUser) async {
    try {
      final response = await http.post(url + "Assign",
          data: jsonEncode({'idPath': idPath, 'idUser': idUser}));
      return UserSaleId.fromJson(response).id;
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deleteUserSale(int id) async {
    try {
      await http.post(url + "Deallocate", data: jsonEncode({'id': id}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<Path> getSelectedPath() async {
    final response = await http.get(url + "GetPathByUser");
    return Path.fromJson(response);
  }
  
  @override
  Future<List<ActivePath>> getActivePaths() async{
    final response = await http.get(url + "GetActivePaths");
    return ActivePaths.fromJson(response).activePaths;
  }
}
