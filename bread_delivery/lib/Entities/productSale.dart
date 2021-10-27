import 'package:bread_delivery/Entities/promotion.dart';

class ProductSale {
  int id;
  double prize;
  String name;
  double cantity;
  double returns;

  ProductSale(this.id, this.name, this.prize, {this.cantity, this.returns});

  double total() => prize * (cantity - returns);

  bool inSale() => (cantity != 0) || (returns != 0);
  List<Promotion> promotion;
}
