class UserCreate {
  String userName;
  String password;
  int userType;
  String name;

  UserCreate({this.userName, this.password, this.userType, this.name});

  UserCreate.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    userType = json['userType'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['userType'] = this.userType;
    data['name'] = this.name;
    return data;
  }
}
