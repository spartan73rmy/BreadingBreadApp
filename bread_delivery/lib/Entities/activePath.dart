class ActivePaths {
  List<ActivePath> activePaths;

  ActivePaths({this.activePaths});

  ActivePaths.fromJson(Map<String, dynamic> json) {
    if (json['activePaths'] != null) {
      activePaths = <ActivePath>[];
      json['activePaths'].forEach((v) {
        activePaths.add(new ActivePath.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activePaths != null) {
      data['activePaths'] = this.activePaths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivePath {
  int id;
  String name;

  ActivePath({this.id, this.name});

  ActivePath.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
