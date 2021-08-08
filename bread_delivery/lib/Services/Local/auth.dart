import 'package:bread_delivery/Entities/token.dart';
import 'package:bread_delivery/Entities/userToken.dart';

import '../../Entities/userType.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final String authTokenKey = 'token';
  static final String refToken = 'refreshToken';
  static final String expDate = 'expirationDate';
  static final String userIdKey = 'idUsuario';
  static final String nameKey = 'nombreUsuario';
  static final String roleKey = 'tipoUsuario';
  static final String userSale = 'idUserSale';
  static final String idCurrentPath = 'idPath';

  static String getToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  static String getRefToken(SharedPreferences prefs) {
    return prefs.getString(refToken);
  }

  static int getIdUser(SharedPreferences prefs) {
    return prefs.getInt(userIdKey);
  }

  static getIdUserSale(SharedPreferences prefs) {
    return prefs.getInt(userSale);
  }

  static getCurrentPath(SharedPreferences prefs) {
    return prefs.getInt(idCurrentPath);
  }

  static bool isAdmin(SharedPreferences prefs) {
    return (prefs.getInt(roleKey) ?? -1) == UserType.adminT; //See value
  }

  static bool isLogged(SharedPreferences prefs) {
    print(getExpDate(prefs).compareTo(DateTime.now()) >= 0);
    return getExpDate(prefs).compareTo(DateTime.now()) >= 0;
  }

  static DateTime getExpDate(SharedPreferences prefs) {
    DateTime date = DateTime.tryParse(prefs.getString(expDate));
    date ?? DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true);
    print(date);
    return date;
  }

  static logoutUser(SharedPreferences prefs) {
    prefs.setString(Auth.authTokenKey, null);
    prefs.setString(Auth.refToken, null);
    prefs.setString(Auth.expDate,
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true).toString());
    prefs.setString(Auth.userIdKey, null);
    prefs.setString(Auth.nameKey, null);
    prefs.setString(Auth.roleKey, null);
  }

  static setIdUserSale(SharedPreferences prefs, int idUserSale) {
    prefs.setInt(userSale, idUserSale);
  }

  static setIdPath(SharedPreferences prefs, int idPath) {
    prefs.setInt(idCurrentPath, idPath);
  }

  static setUserToket(SharedPreferences prefs, UserToken token) {
    prefs.setString(authTokenKey, token.token);
    prefs.setString(refToken, token.refreshToken);
    prefs.setString(expDate, token.expirationDate);

    prefs.setInt(userIdKey, token.user.idUser);
    prefs.setString(nameKey, token.user.userName);
    prefs.setInt(roleKey, token.user.userType);
  }

  static refreshToken(SharedPreferences prefs, Token token) {
    prefs.setString(authTokenKey, token.token);
    prefs.setString(refToken, token.refreshToken);
    prefs.setString(expDate, token.expirationDate);
  }
}
