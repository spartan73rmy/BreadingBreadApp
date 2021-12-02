import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/productInventory.dart';

abstract class PrinterService {
  Future<bool> printZPL(String zpl, String mac);
  Future<String> getZPL(
      List<ProductInventory> inventory, ActivePath inventoryPath);
}

class PrinterServiceImpl extends PrinterService {
  final DateTime now = DateTime.now();
  int x = 10, y = 75;
  String detailProducts = "Producto         Cantidad";

  @override
  Future<String> getZPL(
      List<ProductInventory> inventory, ActivePath inventoryPath) async {
    String ticket = "^XA" +
        "^POI" +
        "^CFA,20" +
        "^FO10,50^FDSAN ANTONIO^FS" +
        "^FO10,75^FDCopia provicional de entraga de pan^FS" +
        separador(25) +
        format('Folio: ${inventoryPath.id}') +
        format("Fecha: " + now.toString()) +
        format("Entrega: ") +
        separador(25) +
        format("RUTA") +
        format(inventoryPath.name) +
        separador(25) +
        format("DETALLES DE ENTREGA") +
        getDetailProducts(inventory) +
        separador(25) +
        format("RECIBE") +
        format(inventoryPath.vendorName) +
        "^LL" +
        (y += 100).toString() +
        "^MMC^XZ";

    return ticket;
  }

  @override
  Future<bool> printZPL(String zpl, String mac) async {
    // TODO: implement printZPL
    throw UnimplementedError();
  }

  String separador(int aumento) {
    String separador2 = "";
    y += aumento;
    for (int i = 0; i < 30; i++) {
      separador2 += "-";
    }
    String result = "^FO10," + '$y^FD' + separador2 + "^FS";

    return result;
  }

  String format(String textToFormat) {
    textToFormat = normalizarTexto(textToFormat);
    String result = "";

    if (textToFormat.length > 30) {
      int ratio = (textToFormat.length / 30.0).ceil();
      int init = 0, end = 30;
      for (int i = 0; i < ratio; i++) {
        y += 25;
        result += '^FO$x,$y^FD' + textToFormat.substring(init, end) + "^FS";
        init = end;
        end += 30;
        if (end > textToFormat.length) {
          end = textToFormat.length;
        }
      }
    } else {
      y += 25;
      result += '^FO$x,$y^FD' + textToFormat + "^FS";
    }

    return result;
  }

  String formatoArtic(String textToFormat, int cantidad) {
    textToFormat = normalizarTexto(textToFormat);
    String result = "";

    if (textToFormat.length > 30) {
      int ratio = (textToFormat.length / 30.0).ceil();
      int start = 0, end = 30;

      for (int i = 0; i < ratio; i++) {
        y += 25;
        result += '^FO$x,$y^FD' + textToFormat.substring(start, end) + "^FS";

        start = end;
        end += 30;
        if (end > textToFormat.length) end = textToFormat.length;
      }

      y += 25;
      result += '^FO$x,$y^FD$cantidad^FS';
    } else {
      y += 25;
      result += '^FO$x,$y^FD' + textToFormat + "^FS";
      y += 25;
      result += '^FO$x,$y^FD$cantidad^FS';
    }
    return result;
  }

  String getDetailProducts(List<ProductInventory> inventory) {
    detailProducts = format(detailProducts);

    inventory.forEach((detail) {
      detailProducts += formatoArtic(detail.name, detail.cantity);
    });

    return detailProducts;
  }

  String normalizarTexto(String invalid) {
    //invalid = Normalizer.normalize(invalid, Normalizer.Form.NFD);
    invalid = invalid.replaceAll("[^\\p{ASCII}]", "");
    return invalid;
  }
}
