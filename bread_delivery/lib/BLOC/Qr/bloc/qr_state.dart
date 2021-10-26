part of 'qr_bloc.dart';

abstract class QrState extends Equatable {
  const QrState();

  @override
  List<Object> get props => [];
}

class QrInitial extends QrState {}

class QrLoading extends QrState {}

class QrError extends QrState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  QrError(this.e);
}

class QrOperationCompleted extends QrState {
  final message;
  QrOperationCompleted(this.message);
}
