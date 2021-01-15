import 'package:bread_delivery/Services/Http/validationErrorHandler.dart';
import 'package:dio/dio.dart';

class NetworkError extends DioError {
  static MyException handleResponse(dynamic error) {
    //Errors handled just catch in Bloc
    if (error is ErrorV) throw error;
    if (error is MyException) throw error;
    dynamic response = error?.response;
    if (response == null)
      return MyException(
          "Sin internet", "Revice que este conectado a internet");

    int statusCode = response?.statusCode;

    if (statusCode == 200) return null;

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return MyException(response.statusCode,
            "No se encuentra autorizado o no tiene permiso");
        break;
      case 404:
        return MyException(
            response.statusCode, "No se encuentra, intente otra vez");
        break;
      case 409:
        return MyException(response.statusCode, "Conflicto en la red");
        break;
      case 408:
        return MyException(response.statusCode,
            "Coneccion de internet lenta, tiempo limite excedido");
        break;
      case 500:
        return MyException(response.statusCode,
            "Error inesperado en el servidor,espere un momento");
        break;
      case 503:
        return MyException(response.statusCode,
            "El servicio no esta disponible temporalmente");
        break;
      default:
        return MyException(response.statusCode, "El error es desconocido");
        break;
    }
  }
}

class MyException extends DioError {
  dynamic error;
  String message;
  MyException(this.error, this.message);
  @override
  String toString() {
    return message?.toString();
  }
}
