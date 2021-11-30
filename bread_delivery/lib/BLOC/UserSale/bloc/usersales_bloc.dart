import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/activePath.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:bread_delivery/Entities/storeViewParams.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Local/auth.dart';
import 'package:bread_delivery/Services/UserSale/userSaleRespository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'usersales_event.dart';
part 'usersales_state.dart';

class UserSalesBloc extends Bloc<UserSalesEvent, UserSalesState> {
  final UserSalesLogic logic;

  UserSalesBloc(this.logic) : super(UserSalesInitial());

  @override
  Stream<UserSalesState> mapEventToState(
    UserSalesEvent event,
  ) async* {
    if (event is GetUserSales) {
      yield UserSalesLoading();
      try {
        //Obtenemos el estado la ruta asignada al usuario
        var currentPath = await logic.getSelectedPath();
        if (currentPath != null)
          Auth.setPath(await SharedPreferences.getInstance(), currentPath.id,
              currentPath.name);

        var idPath = Auth.getCurrentPath(await SharedPreferences.getInstance());
        var pathName =
            Auth.getCurrentPathName(await SharedPreferences.getInstance());

        //Si ya fue seleccionada una ruta se pasa a las tiendas
        if (idPath != null && pathName != null)
          yield UserSaleAssigned(StoreViewParams(idPath, pathName, false));

        //De lo contrario muestra las rutas para seleccionar
        var paths = await logic.fetchPathsList();
        if (paths != null) {
          yield UserSalesLoaded(paths);
        }
        yield UserSalesLoaded(<Path>[]);
      } catch (e) {
        if (e is MyException && e != null) yield UserSalesError(e);
        yield UserSalesLoaded(<Path>[]);
      }
    }

    if (event is AddUserSale) {
      yield UserSalesLoading();
      try {
        var preferences = await SharedPreferences.getInstance();
        int idUser = Auth.getIdUser(preferences);
        int idUserSale = await logic.addUserSale(event.idPath, idUser);
        Auth.setIdUserSale(preferences, idUserSale);
        Auth.setPath(preferences, event.idPath, event.name);
        yield UserSaleAssigned(
            StoreViewParams(event.idPath, event.name, false));
      } catch (e) {
        if (e is MyException && e != null) yield UserSalesError(e);
        yield UserSalesLoaded(<Path>[]);
      }
    }

    if (event is DeleteUserSale) {
      yield UserSalesLoading();
      try {
        await logic.deleteUserSale(event.id);
        yield UserSalesOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield UserSalesError(e);
        yield UserSalesLoaded(<Path>[]);
      }
    }
    
    if(event is GetActivePaths){
      yield UserSalesLoading();
      try {
        var activePaths = await logic.getActivePaths();
        if (activePaths != null) {
          yield ActivePathsLoaded(activePaths);
        }
        yield ActivePathsLoaded(<ActivePath>[]);
      } catch (e) {
        if (e is MyException && e != null) yield UserSalesError(e);
        yield ActivePathsLoaded(<ActivePath>[]);
      }
    }
  }
}
