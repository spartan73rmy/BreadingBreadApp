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
  static final String currentPathName = 'pathName';

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
    if (!prefs.containsKey(idCurrentPath)) return null;
    return prefs.getInt(idCurrentPath);
  }

  static getCurrentPathName(SharedPreferences prefs) {
    if (!prefs.containsKey(currentPathName)) return null;
    return prefs.getString(currentPathName);
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
    prefs.setString(Auth.authTokenKey, "");
    prefs.setString(Auth.refToken, "");
    prefs.setString(Auth.expDate,
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true).toString());
    prefs.setString(Auth.userIdKey, "");
    prefs.setString(Auth.nameKey, "");
    prefs.setString(Auth.roleKey, "");
    prefs.setString(Auth.idCurrentPath, "");
    prefs.setString(Auth.currentPathName, "");
  }

  static setIdUserSale(SharedPreferences prefs, int idUserSale) {
    prefs.setInt(userSale, idUserSale);
  }

  static setPath(SharedPreferences prefs, int idPath, String pathName) {
    prefs.setInt(idCurrentPath, idPath);
    prefs.setString(currentPathName, pathName);
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
