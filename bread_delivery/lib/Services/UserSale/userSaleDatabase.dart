import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SalePreview {
  final int indexProduct;
  final String nameProduct;
  final String priceProduct;
  final String amountSale;
  final String amountReturn;

  SalePreview(
      {this.indexProduct,
      this.nameProduct,
      this.priceProduct,
      this.amountSale,
      this.amountReturn});

  Map<String, dynamic> toMap() {
    return {
      'indexProduct': indexProduct,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'amountSale': amountSale,
      'amountReturn': amountReturn,
    };
  }

  @override
  String toString() {
    return "Index: $indexProduct, AmountSale: $amountSale, AmountReturn: $amountReturn";
  }
}

class SalePreviewDatabase {
  final String table = "userSalePreview";
  Database database;
  init() async {
    database = await openDatabase(join(await getDatabasesPath(), 'my_db.db'),
        version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE userSalePreview(indexProduct INTEGER PRIMARY KEY, nameProduct TEXT, priceProduct TEXT, amountSale TEXT, amountReturn TEXT)');
    });
  }

  Future<void> insert(SalePreview sale) async {
    await database.insert(table, sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SalePreview>> salePreview() async {
    final List<Map<String, dynamic>> maps =
        await database.query('userSalePreview');

    return List.generate(maps.length, (i) {
      return SalePreview(
        indexProduct: maps[i]['indexProduct'],
        nameProduct: maps[i]['nameProduct'],
        priceProduct: maps[i]['priceProduct'],
        amountSale: maps[i]['amountSale'],
        amountReturn: maps[i]['amountReturn'],
      );
    });
  }
}
