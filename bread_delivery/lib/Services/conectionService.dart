import 'dart:io';

class Ping {
  static String url = "Cuenta/";

  Future<bool> ping() async {
    // try {
    //   var uri = HttpModel.getUrl + url + "Ping";
    //   return http
    //       .head(
    //         uri,
    //         headers: {
    //           HttpHeaders.contentTypeHeader: 'application/json',
    //         },
    //       )
    //       .timeout(Duration(seconds: 1))
    //       .then((data) {
    //         if (data.statusCode == 200) {
    //           return true;
    //         }
    //         return false;
    //       })
    //       .catchError((error) => false);
    // } on SocketException catch (_) {
    //   return false;
    // }
  }
}
