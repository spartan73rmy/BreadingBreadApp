import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Qr/QrRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final QrLogic logic;
  QrBloc(this.logic) : super(QrInitial());

  @override
  Stream<QrState> mapEventToState(QrEvent event) async* {
    if (event is SetCoordsStore) {
      yield QrLoading();
      try {
        await logic.setStoreCoords(event.id, event.coords);
        yield QrOperationCompleted(
            "Las coordenadas fueron establecidas correctamente");
      } catch (e) {
        if (e is MyException && e != null) yield QrError(e);
      }
    }
  }
}
