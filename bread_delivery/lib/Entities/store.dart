class Stores {
  List<Store> stores;

  Stores({this.stores});

  Stores.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = [];
      json['stores'].forEach((v) {
        stores.add(new Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stores != null) {
      data['stores'] = this.stores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int id;
  String name;
  double lat;
  double lon;
  bool visited;

  Store({this.id, this.name, this.lat, this.lon, this.visited});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    visited = json['visited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['visited'] = this.visited;
    return data;
  }
}
