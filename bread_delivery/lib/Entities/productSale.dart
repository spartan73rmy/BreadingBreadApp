import "package:bread_delivery/Entities/promotion.dart";

class ProductSale {
  int id;
  double prize;
  String name;
  int cantity;
  int returns;
  Promotion promotionApplied;

  ProductSale(this.id, this.name, this.prize, this.promotions,
      {this.cantity, this.returns});

  double total() => prize * (cantity - returns);

  bool inSale() => (cantity != 0) || (returns != 0);

  List<Promotion> promotions;

  Map<String, dynamic> toJson() {
    return {
      "idProduct": this.id,
      "cantity": this.cantity,
      "unitPrice": this.prize,
      "total": this.total(),
      "idPromo": this.promotionApplied?.idPromo ?? 0,
      "promoCantity": this.promotionApplied?.cantityFree ?? 0,
      "returnCantity": this.returns ?? 0,
      "discount": this.promotionApplied?.discount ?? 0
    };
  }
}
