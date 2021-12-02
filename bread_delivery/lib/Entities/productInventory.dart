class ProductsInventory {
  List<ProductInventory> products;

  ProductsInventory({this.products});

  ProductsInventory.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new ProductInventory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInventory {
  int id;
  String name;
  int cantity;

  ProductInventory({this.id, this.name, this.cantity});

  ProductInventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cantity = json['cantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cantity'] = this.cantity;
    return data;
  }
}
