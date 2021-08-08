import 'dart:convert';

class StoreQr {
  int id;

  StoreQr(this.id);

  StoreQr.decodeString(String value) {
    Map json = jsonDecode(value);
    StoreQr.fromJson(json);
  }
  StoreQr.fromJson(Map<String, dynamic> json) {
    id = json['idStoreQr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idStoreQr'] = this.id;
    return data;
  }
}
