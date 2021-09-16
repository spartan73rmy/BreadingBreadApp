import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PriorSale {
  final int indexProduct;
  final String nameProduct;
  final String priceProduct;
  final String saleQuantity;
  final String refundAmount;

  PriorSale(
      {this.indexProduct,
      this.nameProduct,
      this.priceProduct,
      this.saleQuantity,
      this.refundAmount});

  Map<String, dynamic> toMap() {
    return {
      'indexProduct': indexProduct,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'saleQuantity': saleQuantity,
      'refundAmount': refundAmount,
    };
  }
}

class PriorSaleDatabase {
  final String table = "userSalePreview";
  Database database;
  init() async {
    database = await openDatabase(
        join(await getDatabasesPath(), 'db_SalePrevious.db'),
        version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE userSalePreview(indexProduct INTEGER PRIMARY KEY, nameProduct TEXT, priceProduct TEXT, saleQuantity TEXT, refundAmount TEXT)');
    });
  }

  Future<void> insert(PriorSale sale) async {
    await database.insert(table, sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PriorSale>> salePreview() async {
    final List<Map<String, dynamic>> maps =
        await database.query('userSalePreview');

    return List.generate(maps.length, (i) {
      return PriorSale(
        indexProduct: maps[i]['indexProduct'],
        nameProduct: maps[i]['nameProduct'],
        priceProduct: maps[i]['priceProduct'],
        saleQuantity: maps[i]['saleQuantity'],
        refundAmount: maps[i]['refundAmount'],
      );
    });
  }
}
