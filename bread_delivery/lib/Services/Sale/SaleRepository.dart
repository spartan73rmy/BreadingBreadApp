import 'dart:convert';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:bread_delivery/Entities/sale.dart';
import 'package:bread_delivery/Services/Http/dioClient.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';

abstract class SaleLogic {
  Future<List<Product>> fetchProductsList();
  Future<List<Promotion>> fetchPromotionsByProduct(int idProduct);
  Future<int> addSale(Sale sale);
}

class SaleRepository extends SaleLogic {
  static const String url = "Sale/";
  static const String urlPath = "Path/";
  DioClient http = DioClient();

  @override
  Future<int> addSale(Sale sale) async {
    try {
      print(sale.toJson());
      print(jsonEncode(sale.toJson()));

      final response =
          await http.post(url + "Add", data: jsonEncode(sale.toJson()));
      return response;
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  Future<List<Product>> fetchProductsList() async {
    const String url = "Product/";
    try {
      final response = await http.get(url + "GetList");
      return Products.fromJson(response).products;
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<List<Promotion>> fetchPromotionsByProduct(int idProduct) async {
    const String url = "Promotion/";
    try {
      final response = await http.get(url + 'GetListByProduct/',
          queryParameters: {'idProduct': idProduct});
      return Promotions.fromJson(response).promotions;
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
