import '../../Services/Http/dioClient.dart';

class StoreRepository {
  static const String url = "Store/getList";
  DioClient http = DioClient();

  Future<List<Store>> fetchMovieList() async {
    final response = await http.get(url);
    // return MovieResponse.fromJson(response).results;
  }
}

class Store {}
