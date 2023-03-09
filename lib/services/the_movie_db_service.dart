import 'package:dio/dio.dart';
import 'package:interview_test/models/movie_model.dart';

class TheMovieDBService {
  final Dio dio = Dio();

  final urlBase = 'https://api.themoviedb.org';
  final apiVersion = '/3';
  final endpoint = '/movie/popular';

  Future<List<MovieModel>> getPopularMovies() async {
    const queryString =
        '?api_key=0e71f29dbddf72cb1bd78b342a3424d2&language=en-US&page=1';
    final urlRequest = urlBase + apiVersion + endpoint + queryString;
    final response = await dio.get(urlRequest);

    if (response.statusCode == 200) {
      final moviesJson = response.data['results'];
      final movies = List<MovieModel>.from(
          moviesJson.map((json) => MovieModel.fromJson(json)));
      return movies;
    }

    throw Exception('Something happened');
  }
}
