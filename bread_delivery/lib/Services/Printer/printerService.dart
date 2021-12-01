import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/product.dart';

abstract class PrinterService {
  Future<bool> printZPL(String zpl, String mac);
  Future<String> getZPL(List<Product> inventory, ActivePath inventoryPath);
}

class PrinterServiceImpl extends PrinterService {
  @override
  Future<String> getZPL(
      List<Product> inventory, ActivePath inventoryPath) async {
    // TODO: implement getZPL
    throw UnimplementedError();
  }

  @override
  Future<bool> printZPL(String zpl, String mac) async {
    // TODO: implement printZPL
    throw UnimplementedError();
  }
}
