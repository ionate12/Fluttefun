import 'package:dio/dio.dart';

/// Handles raw HTTP calls to the TMDB API.
class MovieApiService {
  final Dio _dio;

  MovieApiService(this._dio);

  Future<Map<String, dynamic>> getPopularMovies({int page = 1}) async {
    final response = await _dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> searchMovies(String query, {int page = 1}) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'page': page},
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getMovieDetail(int movieId) async {
    final response = await _dio.get('/movie/$movieId');
    return response.data as Map<String, dynamic>;
  }
}
