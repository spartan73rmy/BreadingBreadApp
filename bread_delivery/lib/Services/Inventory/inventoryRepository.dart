import 'dart:convert';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class InventoryLogic {
  Future<List<Product>> fetchProductsList();
  Future<void> addProduct(String name, double price);
}

class InventoryRepository extends InventoryLogic {
  static const String url = "Product/";
  DioClient http = DioClient();

  Future<List<Product>> fetchProductsList() async {
    final response = await http.get(url + "GetList");
    return Products.fromJson(response).products;
  }

  @override
  Future<void> addProduct(String name, double price) async {
    try {
      await http.post(url + "Add",
          data: jsonEncode({'name': name, 'price': price}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}