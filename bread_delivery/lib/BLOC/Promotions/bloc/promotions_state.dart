part of 'promotions_bloc.dart';

abstract class PromotionsState extends Equatable {
  const PromotionsState();

  @override
  List<Object> get props => [];
}

class PromotionsInitial extends PromotionsState {}

class PromotionsLoading extends PromotionsState {}

class PromotionsError extends PromotionsState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  PromotionsError(this.e);
}

class PromotionsLoaded extends PromotionsState {
  // ignore: non_constant_identifier_names
  final List<Promotion> promotions;

  PromotionsLoaded(this.promotions);
}

class PromotionOperationCompleted extends PromotionsState {}
