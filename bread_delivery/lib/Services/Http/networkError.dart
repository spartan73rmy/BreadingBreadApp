import 'package:dio/dio.dart';

class NetworkError extends DioError {
  static MyException handleResponse(DioError error) {
    dynamic response = error.response;
    if (response == null)
      return MyException(
          "Sin internet", "Revice que este conectado a internet");

    int statusCode = response.statusCode;

    if (statusCode == 200) return null;

    switch (statusCode) {
      case 0:
        return MyException("Sin Internet", "Revice su coneccion a internet");
      case 400:
        return MyException(
            "Peticion Invalida", "Error en la peticion al servidor");
      case 401:
      case 403:
        return MyException(
            response.statusCode, "No se encuentra autorizado, inicie sesion");
        break;
      case 404:
        return MyException(response.statusCode, "No se encuentra el elemento");
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
            "Error en el servidor, consulte al administrador");
        break;
      case 503:
        return MyException(response.statusCode,
            "El servicio no esta disponible, consulte al administrador");
        break;
      default:
        return MyException(
            response.statusCode, "Error desconocido, codigo $statusCode");
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
