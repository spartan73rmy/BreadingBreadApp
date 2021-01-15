class ErrorDetails {
  String error;
  Details details;

  ErrorDetails({this.error, this.details});

  ErrorDetails.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }
}

class Details {
  String detailsList = "";

  Details({this.detailsList});

  Details.fromJson(Map<String, dynamic> json) {
    for (var key in json.keys) {
      print(key);
      if (key == null) continue;
      dynamic valor = json[key];
      if (valor == null) continue;
      List<String> lista = new List<String>.from(valor);
      if (lista is List<String>) {
        for (String detail in lista) {
          print(detail);
          detailsList += "$detail\n";
          print(detailsList);
        }
      }
    }
  }
}
