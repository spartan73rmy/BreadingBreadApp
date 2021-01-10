class NetworkError {
  static Future<MyException> handleResponse(int statusCode) async {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return MyException("No se encuentra autorizado, inicie sesion");
        break;
      case 404:
        return MyException("No se encuentra el elemento");
        break;
      case 409:
        return MyException("Conflicto en la red");
        break;
      case 408:
        return MyException(
            "Coneccion de internet lenta, tiempo limite excedido");
        break;
      case 500:
        return MyException("Error en el servidor, consulte al administrador");
        break;
      case 503:
        return MyException(
            "El servicio no esta disponible, consulte al administrador");
        break;
      default:
        return MyException("Error desconocido, codigo $statusCode");
    }
  }
}

class MyException {
  String error;
  MyException(this.error);
}
