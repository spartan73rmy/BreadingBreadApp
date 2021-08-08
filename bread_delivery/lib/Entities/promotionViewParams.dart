import 'package:bread_delivery/Entities/product.dart';
import 'package:bread_delivery/Entities/promotion.dart';

class PromotionViewParams {
  final bool isAdmin;
  final Product producto;
  PromotionViewParams(this.isAdmin,this.producto);
}