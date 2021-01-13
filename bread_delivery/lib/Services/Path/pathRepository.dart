import 'package:bread_delivery/Entities/path.dart';
import '../../Services/Http/dioClient.dart';

abstract class PathsLogic {
  Future<List<Path>> fetchPathsList();
}

class PathRepository extends PathsLogic {
  static const String url = "Path/GetList";
  DioClient http = DioClient();

  Future<List<Path>> fetchPathsList() async {
    final response = await http.get(url);
    return Paths.fromJson(response).paths;
  }
}
