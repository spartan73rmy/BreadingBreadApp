class UserToken {
  User user;
  String token;
  String refreshToken;
  int userType;
  String expirationDate;

  UserToken(
      {this.user,
      this.token,
      this.refreshToken,
      this.userType,
      this.expirationDate});

  UserToken.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    refreshToken = json['refreshToken'];
    userType = json['userType'];
    expirationDate = json['expirationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['userType'] = this.userType;
    data['expirationDate'] = this.expirationDate;
    return data;
  }
}

class User {
  int idUser;
  String userName;
  int userType;
  String refreshToken;

  User({this.idUser, this.userName, this.userType, this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    userName = json['userName'];
    userType = json['userType'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['userName'] = this.userName;
    data['userType'] = this.userType;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
