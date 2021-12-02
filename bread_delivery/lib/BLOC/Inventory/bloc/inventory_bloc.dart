import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/productInventory.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Inventory/inventoryRepository.dart';
import 'package:bread_delivery/Services/Printer/printerService.dart';
import 'package:equatable/equatable.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryLogic logic;
  final PrinterService printerService;

  InventoryBloc(this.logic, this.printerService) : super(InventoryInitial());

  @override
  Stream<InventoryState> mapEventToState(
    InventoryEvent event,
  ) async* {
    if (event is GetProducts) {
      yield InventoryLoading();
      try {
        var products = await logic.fetchProductsList();
        if (products != null) {
          yield ProductsLoaded(products);
        }
        yield ProductsLoaded(<ProductInventory>[]);
      } catch (e) {
        if (e is MyException && e != null) yield InventoryError(e);
        yield ProductsLoaded(<ProductInventory>[]);
      }
    }

    if (event is AddInventoryProducts) {
      //Si la impresion es opcional no importa si se imprime o no el ticket
      //TODO IMPLEMENTAR GET Y PRINT ZPL
      var zpl = await printerService.getZPL(event.products, event.activePath);
      var isPrinted = await printerService.printZPL(zpl, event.btMAC);

      if (isPrinted) {
        //logic.addProduct(name, price)
        //TODO agregar codigo para imprimir y guardar el inventario de esa ruta
      } else {
        yield InventoryError(new MyException("Error en impresora",
            "Error al imprimir, compruebe la impresora por favor"));
      }
    }
  }
}
