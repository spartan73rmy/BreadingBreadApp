class Promotions {
  List<Promotion> promotions;

  Promotions({this.promotions});

  Promotions.fromJson(Map<String, dynamic> json) {
    if (json['promotions'] != null) {
      promotions = new List<Promotion>();
      json['promotions'].forEach((v) {
        promotions.add(new Promotion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promotions != null) {
      data['promotions'] = this.promotions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Promotion {
  int idPromo;
  int idProducto;
  int cantitySaleMin;
  int saleMin;
  int cantityFree;
  int discount;

  Promotion(
      {this.idPromo,
      this.idProducto,
      this.cantitySaleMin,
      this.saleMin,
      this.cantityFree,
      this.discount});

  Promotion.fromJson(Map<String, dynamic> json) {
    idPromo = json['idPromo'];
    idProducto = json['idProducto'];
    cantitySaleMin = json['cantitySaleMin'];
    saleMin = json['saleMin'];
    cantityFree = json['cantityFree'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPromo'] = this.idPromo;
    data['idProducto'] = this.idProducto;
    data['cantitySaleMin'] = this.cantitySaleMin;
    data['saleMin'] = this.saleMin;
    data['cantityFree'] = this.cantityFree;
    data['discount'] = this.discount;
    return data;
  }
}