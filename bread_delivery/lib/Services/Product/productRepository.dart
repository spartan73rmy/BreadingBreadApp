import 'dart:convert';

import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class ProductsLogic {
  Future<List<Product>> fetchProductsList();
  Future<void> addProduct(String name, double price);
  Future<void> editProduct(int id, String name, double price);
  Future<void> deleteProduct(int id);
}

class ProductRepository extends ProductsLogic {
  static const String url = "Product/";
  DioClient http = DioClient();

  Future<List<Product>> fetchProductsList() async {
    final response = await http.get(url + "GetList");
    return Products.fromJson(response).products;
  }

  @override
  Future<void> addProduct(String name, double price) async {
    try {
      await http.post(url + "Add", data: jsonEncode({'name': name, 'price':price}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> editProduct(int id, String name, double price) async {
    try {
      await http.post(url + "Edit", data: jsonEncode({'id': id, 'name': name, 'price': price}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await http.post(url + "Delete", data: jsonEncode({'id': id}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
