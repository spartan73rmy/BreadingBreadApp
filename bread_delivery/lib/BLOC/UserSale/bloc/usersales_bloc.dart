import 'dart:async';

import 'package:bloc/bloc.dart';
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
        int idUser = Auth.getIdUser(await SharedPreferences.getInstance());
        int idUserSale = await logic.addUserSale(event.idPath, idUser);
        Auth.setIdUserSale(await SharedPreferences.getInstance(), idUserSale);

        yield UserSaleAssigned(StoreViewParams(event.idPath, false));
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
  }
}