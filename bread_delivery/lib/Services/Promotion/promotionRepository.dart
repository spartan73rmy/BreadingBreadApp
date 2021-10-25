import 'dart:convert';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class PromotionsLogic {
  Future<List<Promotion>> fetchPromotionsList();
  Future<List<Promotion>> fetchPromotionsListByProduct(int idProducto);
  Future<void> addPromotion(int idProducto, int cantitySaleMin, double saleMin,
      int cantityFree, int discount);
  Future<void> editPromotion(int idPromo, int idProducto, int cantitySaleMin,
      double saleMin, int cantityFree, int discount, bool active);
  Future<void> deletePromotion(int idPromo);
}

class PromotionRepository extends PromotionsLogic {
  static const String url = "Promotion/";
  DioClient http = DioClient();

  Future<List<Promotion>> fetchPromotionsList() async {
    final response = await http.get(url + "GetList");
    return Promotions.fromJson(response).promotions;
  }

  Future<List<Promotion>> fetchPromotionsListByProduct(int idProducto) async {
    final response = await http.get(url + "GetListByProduct",
        queryParameters: {'idProduct': idProducto});
    return Promotions.fromJson(response).promotions;
  }

  @override
  Future<void> addPromotion(int idProducto, int cantitySaleMin, double saleMin,
      int cantityFree, int discount) async {
    try {
      await http.post(url + "Add",
          data: jsonEncode({
            'idProducto': idProducto,
            'cantitySaleMin': cantitySaleMin,
            'saleMin': saleMin,
            'cantityFree': cantityFree,
            'discount': discount
          }));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> editPromotion(int idPromo, int idProducto, int cantitySaleMin,
      double saleMin, int cantityFree, int discount, bool active) async {
    try {
      await http.post(url + "Edit",
          data: jsonEncode({
            'id': idPromo,
            'idProducto': idProducto,
            'cantitySaleMin': cantitySaleMin,
            'saleMin': saleMin,
            'cantityFree': cantityFree,
            'discount': discount,
            'active': active
          }));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }

  @override
  Future<void> deletePromotion(int idPromo) async {
    try {
      await http.post(url + "Delete", data: jsonEncode({'id': idPromo}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
