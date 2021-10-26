import 'package:bread_delivery/Entities/promotion.dart';

class ProductSale {
  int id;
  double prize;
  String name;
  double cantity;
  double returns;

  ProductSale(this.id, this.name, this.prize);

  double total() => prize * (cantity - returns);

  List<Promotion> promotion;
}
