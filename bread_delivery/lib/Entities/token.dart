class Token {
  String token;
  String refreshToken;
  int userType;
  String expirationDate;

  Token({this.token, this.refreshToken, this.userType, this.expirationDate});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    userType = json['userType'];
    expirationDate = json['expirationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['userType'] = this.userType;
    data['expirationDate'] = this.expirationDate;
    return data;
  }
}
