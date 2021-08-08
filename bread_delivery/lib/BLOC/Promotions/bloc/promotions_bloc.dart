import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/promotion.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Promotion/promotionRepository.dart';
import 'package:equatable/equatable.dart';

part 'promotions_event.dart';
part 'promotions_state.dart';

class PromotionsBloc extends Bloc<PromotionsEvent, PromotionsState> {
  final PromotionsLogic logic;

  PromotionsBloc(this.logic) : super(PromotionsInitial());

  @override
  Stream<PromotionsState> mapEventToState(
    PromotionsEvent event,
  ) async* {
    if (event is GetPromotions) {
      yield PromotionsLoading();
      try {
        var promotions = await logic.fetchPromotionsList();
        if (promotions != null) {
          yield PromotionsLoaded(promotions);
        }
        yield PromotionsLoaded(<Promotion>[]);
      } catch (e) {
        if (e is MyException && e != null) yield PromotionsError(e);
        yield PromotionsLoaded(<Promotion>[]);
      }
    }
    if (event is GetPromotionsByProduct) {
      yield PromotionsLoading();
      try {
        var promotions = await logic.fetchPromotionsListByProduct(event.idProducto);
        if (promotions != null) {
          yield PromotionsLoaded(promotions);
        }
        yield PromotionsLoaded(<Promotion>[]);
      } catch (e) {
        if (e is MyException && e != null) yield PromotionsError(e);
        yield PromotionsLoaded(<Promotion>[]);
      }
    }

    if (event is AddPromotion) {
      yield PromotionsLoading();
      try {
        await logic.addPromotion(event.idProducto, event.cantitySaleMin,
            event.saleMin, event.cantityFree, event.discount);
        yield PromotionOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield PromotionsError(e);
        yield PromotionsLoaded(<Promotion>[]);
      }
    }
    if (event is EditPromotion) {
      yield PromotionsLoading();
      try {
        await logic.editPromotion(
            event.idPromo,
            event.idProducto,
            event.cantitySaleMin,
            event.saleMin,
            event.cantityFree,
            event.discount,
            event.active);
        yield PromotionOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield PromotionsError(e);
        yield PromotionsLoaded(<Promotion>[]);
      }
    }

    if (event is DeletePromotion) {
      yield PromotionsLoading();
      try {
        await logic.deletePromotion(event.id);
        yield PromotionOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield PromotionsError(e);
        yield PromotionsLoaded(<Promotion>[]);
      }
    }
  }
}
