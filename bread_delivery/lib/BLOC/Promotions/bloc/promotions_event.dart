part of 'promotions_bloc.dart';

abstract class PromotionsEvent extends Equatable {
  const PromotionsEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetPromotions extends PromotionsEvent {
  GetPromotions() : super([]);
}

class AddPromotion extends PromotionsEvent {
  final int idProducto;
  final int cantitySaleMin;
  final int saleMin;
  final int cantityFree;
  final int discount;

  AddPromotion(this.idProducto, this.cantitySaleMin, this.saleMin,
      this.cantityFree, this.discount)
      : super([idProducto, cantitySaleMin, saleMin, cantityFree, discount]);
}

class EditPromotion extends PromotionsEvent {
  final int idPromo;
  final int idProducto;
  final int cantitySaleMin;
  final int saleMin;
  final int cantityFree;
  final int discount;
  final bool active;

  EditPromotion(this.idPromo, this.idProducto, this.cantitySaleMin,
      this.saleMin, this.cantityFree, this.discount, this.active)
      : super([
          idPromo,
          idProducto,
          cantitySaleMin,
          saleMin,
          cantityFree,
          discount,
          active
        ]);
}

class DeletePromotion extends PromotionsEvent {
  final int id;

  DeletePromotion(this.id) : super([id]);
}
