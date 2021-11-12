import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/productSale.dart';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:bread_delivery/Entities/sale.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Sale/SaleRepository.dart';
import 'package:equatable/equatable.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final SaleLogic logic;

  SaleBloc(this.logic) : super(SaleInitial());

  @override
  Stream<SaleState> mapEventToState(
    SaleEvent event,
  ) async* {
    if (event is GetProductForSale) {
      yield SaleLoading();
      try {
        var products = await logic.fetchProductsList();
        if (products != null) {
          List<ProductSale> productsToSale = <ProductSale>[];

          for (var product in products) {
            var promotions = await logic.fetchPromotionsByProduct(product.id);
            productsToSale.add(ProductSale(
              product.id,
              product.name,
              product.price,
              promotions ?? <Promotion>[],
              cantity: 0,
              returns: 0,
            ));
          }
          yield ProductsForSaleLoaded(productsToSale);
        }
        yield ProductsForSaleLoaded(<ProductSale>[]);
      } catch (e) {
        if (e is MyException && e != null) yield SaleError(e);
        yield ProductsForSaleLoaded(<ProductSale>[]);
      }
    }

    if (event is AddSale) {
      yield SaleLoading();
      try {
        //TODO get current coords to sale
        event.sale.lat = 1.0;
        event.sale.lon = 1.0;
        int id = await logic.addSale(event.sale);
        if (id >= 0) yield SaleOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null)
          yield SaleError(e);
        else
          yield SaleOperationCompleted();
      }
    }
  }
}
