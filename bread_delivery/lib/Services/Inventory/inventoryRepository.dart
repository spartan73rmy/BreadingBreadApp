import 'package:bread_delivery/Entities/productInventory.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import '../../Services/Http/dioClient.dart';

abstract class InventoryLogic {
  Future<List<ProductInventory>> fetchProductsList();
  Future<void> SetInventoryToPath(int idUserSale, List<ProductInventory> Inventory);
}

class InventoryRepository extends InventoryLogic {
  static const String url = "Inventory/";
  DioClient http = DioClient();

  Future<List<ProductInventory>> fetchProductsList() async {
    final response = await http.get(url + "GetList");
    return ProductsInventory.fromJson(response).products;
  }

  @override
  Future<void> SetInventoryToPath(int idUserSale, List<ProductInventory> Inventory) async {
    try {
      await http.post(url + "Set",
          data: Inventario(idSaleUser: idUserSale, inventory: Inventory).toJson());
    } catch (e) {
      throw NetworkError.handleResponse(e);
    }
  }
}
