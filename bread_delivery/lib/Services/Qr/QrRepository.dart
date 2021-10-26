import 'dart:convert';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:geolocator/geolocator.dart';
import '../../Services/Http/dioClient.dart';

abstract class QrLogic {
  Future<void> setStoreCoords(int id, Position coords);
}

class QrRepository extends QrLogic {
  static const String url = "Store/";
  DioClient http = DioClient();

  @override
  Future<void> setStoreCoords(int id, Position coords) async {
    try {
      await http.post(url + "SetCoordinates",
          data: jsonEncode(
              {'id': id, 'lat': coords.latitude, 'long': coords.longitude}));
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
