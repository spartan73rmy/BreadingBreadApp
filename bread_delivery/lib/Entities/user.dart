class Users {
  List<User> usuarios;

  Users({this.usuarios});

  Users.fromJson(Map<String, dynamic> json) {
    if (json['usuarios'] != null) {
      usuarios = [];
      json['usuarios'].forEach((v) {
        usuarios.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.usuarios != null) {
      data['usuarios'] = this.usuarios.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int id;
  String userName;
  String name;
  int userType;
  bool aproved;

  User({this.id, this.userName, this.name, this.userType, this.aproved});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    name = json['name'];
    userType = json['userType'];
    aproved = json['aproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['userType'] = this.userType;
    data['aproved'] = this.aproved;
    return data;
  }
}
