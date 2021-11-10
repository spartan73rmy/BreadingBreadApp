import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/productSale.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Product/productRepository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsLogic logic;

  ProductsBloc(this.logic) : super(ProductsInitial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is GetProducts) {
      yield ProductsLoading();
      try {
        var products = await logic.fetchProductsList();
        if (products != null) {
          yield ProductsLoaded(products);
        }
        yield ProductsLoaded(<Product>[]);
      } catch (e) {
        if (e is MyException && e != null) yield ProductsError(e);
        yield ProductsLoaded(<Product>[]);
      }
    }

    if (event is AddProduct) {
      yield ProductsLoading();
      try {
        await logic.addProduct(event.name, event.price);
        yield ProductOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield ProductsError(e);
        yield ProductsLoaded(<Product>[]);
      }
    }
    if (event is EditProduct) {
      yield ProductsLoading();
      try {
        await logic.editProduct(event.id, event.name, event.price);
        yield ProductOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield ProductsError(e);
        yield ProductsLoaded(<Product>[]);
      }
    }

    if (event is DeleteProduct) {
      yield ProductsLoading();
      try {
        await logic.deleteProduct(event.id);
        yield ProductOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield ProductsError(e);
        yield ProductsLoaded(<Product>[]);
      }
    }
  }
}
