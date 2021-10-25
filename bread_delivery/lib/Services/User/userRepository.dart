import 'dart:convert';
import 'package:bread_delivery/Entities/user.dart';
import 'package:bread_delivery/Entities/userCreate.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../Http/dioClient.dart';

abstract class UserLogic {
  Future<List<User>> fetchUsersList();
  Future<dynamic> addUser(UserCreate user);
  Future<void> editUser(int id, String name);
  Future<void> deleteUser(String userName);
  Future<void> approveUser(String userName);
}

class UserRepository extends UserLogic {
  static const String url = "User/";
  static const String urlCuenta = "Cuenta/";

  DioClient http = DioClient();

  Future<List<User>> fetchUsersList() async {
    final response = await http.get(url + "GetList");
    return Users.fromJson(response).usuarios;
  }

  @override
  Future<dynamic> addUser(UserCreate user) async {
    return await http.post(urlCuenta + "CreateUser",
        data: jsonEncode(user.toJson()));
  }

  @override
  Future<void> editUser(int id, String name) async {
    try {
      await http.post(url + "Edit", data: jsonEncode({'id': id, 'name': name}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deleteUser(String userName) async {
    try {
      await http.post(url + "Delete", data: jsonEncode({'userName': userName}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> approveUser(String userName) async {
    try {
      await http.post(url + "Aprove", data: jsonEncode({'userName': userName}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
