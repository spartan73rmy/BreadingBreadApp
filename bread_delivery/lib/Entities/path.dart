class Paths {
  List<Path> paths;

  Paths({this.paths});

  Paths.fromJson(Map<String, dynamic> json) {
    if (json['paths'] != null) {
      paths = new List<Path>();
      json['paths'].forEach((v) {
        paths.add(new Path.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paths != null) {
      data['paths'] = this.paths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Path {
  int id;
  String name;
  bool selected;

  Path({this.id, this.name, this.selected});

  Path.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['selected'] = this.selected;
    return data;
  }
}
