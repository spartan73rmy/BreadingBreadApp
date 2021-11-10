import 'package:bread_delivery/Entities/productSale.dart';

class Sale {
  int idPath;
  int idStore;
  double lat;
  double lon;
  double total;

  String commentary;
  List<ProductSale> products;

  Sale(this.idPath, this.idStore, this.total, this.products, this.commentary,
      {this.lat, this.lon});
}
