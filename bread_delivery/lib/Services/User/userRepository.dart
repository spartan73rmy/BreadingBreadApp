import 'dart:convert';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../Http/dioClient.dart';

abstract class UserLogic {
  Future<List<UserCreate>> fetchUsersList();
  Future<void> addUser(UserCreate user);
  Future<void> editUser(UserCreate user);
  Future<void> deleteUser(int id);
}

class UserRepository extends UserLogic {
  static const String url = "User/";
  static const String urlCuenta = "Cuenta/";

  DioClient http = DioClient();

  Future<List<UserCreate>> fetchUsersList() async {
    final response = await http.get(url + "GetList");
    return List<UserCreate>();
  }

  @override
  Future<void> addUser(UserCreate user) async {
    try {
      await http.post(urlCuenta + "CreateUser",
          data: jsonEncode(user.toJson()));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> editUser(UserCreate user) async {
    try {
      await http.post(url + "Edit", data: jsonEncode(user.toJson()));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await http.post(url + "Delete", data: jsonEncode({'id': id}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
