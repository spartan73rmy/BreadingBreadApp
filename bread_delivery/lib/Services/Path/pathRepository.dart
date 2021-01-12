import 'package:bread_delivery/Entities/path.dart';
import '../../Services/Http/dioClient.dart';

class PathRepository {
  static const String url = "Path/GetList";
  DioClient http = DioClient();

  Future<List<Path>> fetchPathsList() async {
    final response = await http.get(url);
    return Paths.fromJson(response).paths;
  }
}
