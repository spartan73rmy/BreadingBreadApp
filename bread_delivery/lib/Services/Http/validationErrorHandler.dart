import 'package:bread_delivery/Entities/errorDetails.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:dio/dio.dart';

class ValidationErrorHandler {
  static validate(dynamic response) {
    int statusCode = response?.statusCode;
    dynamic data = response?.data;
    var value = ErrorDetails.fromJson(data);
    switch (statusCode) {
      case 400:
        throw ErrorV(value.error, value.details.detailsList);
        break;
      case 401:
        throw ErrorV(value.error, value.details.detailsList);
      case 403:
        throw MyException(response.statusCode,
            "No se encuentra autorizado o no tiene permiso");
        break;
      case 404:
        throw MyException(response.statusCode,
            "No se encuentra el elemento, refresque la pagina e intente otra vez");
        break;
      case 409:
        throw MyException(response.statusCode, "Conflicto en la red");
        break;
      case 408:
        throw MyException(response.statusCode,
            "Coneccion de internet lenta, tiempo limite excedido");
        break;
      case 500:
        throw MyException(response.statusCode,
            "Error inesperado en el servidor,espere un momento");
        break;
      case 503:
        throw MyException(response.statusCode,
            "El servicio no esta disponible temporalmente");
        break;
    }
  }
}

class ErrorV extends DioError {
  final String message;
  final String details;
  ErrorV(this.message, this.details);
}
