import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/productSale.dart';
import 'package:bread_delivery/Entities/store.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';

class UserSaleViewParams {
  final StoreViewParams selectedPath;
  Store selectedStore;
  List<Store> stores;
  List<ProductSale> products;

  UserSaleViewParams(this.selectedPath,
      {this.selectedStore, this.stores, this.products});
}
