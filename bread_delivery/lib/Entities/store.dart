class Stores {
  List<Store> stores;

  Stores({this.stores});

  Stores.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = new List<Store>();
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

  Store({this.id, this.name});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
