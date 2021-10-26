part of 'qr_bloc.dart';

abstract class QrEvent extends Equatable {
  const QrEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class SetCoordsStore extends QrEvent {
  final Position coords;
  final int id;

  SetCoordsStore(this.id, this.coords) : super([id, coords]);
}
