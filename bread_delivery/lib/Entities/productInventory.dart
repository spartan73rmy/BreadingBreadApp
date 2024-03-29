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

class Inventario {
  int idSaleUser;
  List<ProductInventory>inventory;

  Inventario({this.idSaleUser, this.inventory});

  Inventario.fromJson(Map<String, dynamic> json) {
    idSaleUser = json['idSaleUser'];
    if (json['inventory'] != null) {
      inventory = <ProductInventory>[];
      json['inventory'].forEach((v) {
        inventory.add(new ProductInventory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSaleUser'] = this.idSaleUser;
    if (this.inventory != null) {
      data['inventory'] = this.inventory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInventory {
  int id;
  String name;
  int quantity;

  ProductInventory({this.id, this.name, this.quantity});

  ProductInventory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
