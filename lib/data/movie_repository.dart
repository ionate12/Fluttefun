import 'package:dio/dio.dart';

import '../models/movie.dart';
import 'movie_api_service.dart';

/// Converts raw API data into domain models.
class MovieRepository {
  final MovieApiService _apiService;

  MovieRepository(this._apiService);

  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    try {
      final data = await _apiService.getPopularMovies(page: page);
      final results = data['results'] as List<dynamic>;
      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    try {
      final data = await _apiService.searchMovies(query, page: page);
      final results = data['results'] as List<dynamic>;
      return results.map((json) => Movie.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<Movie> fetchMovieDetail(int movieId) async {
    try {
      final data = await _apiService.getMovieDetail(movieId);
      return Movie.fromJson(data);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timed out. Please try again.');
      case DioExceptionType.connectionError:
        return Exception('No internet connection.');
      default:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return Exception('Invalid API key. Check your TMDB API key in constants.dart.');
        }
        if (statusCode == 404) {
          return Exception('Movie not found.');
        }
        return Exception('Something went wrong. Please try again.');
    }
  }
}
