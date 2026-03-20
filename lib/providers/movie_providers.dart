import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../data/movie_api_service.dart';
import '../data/movie_repository.dart';
import '../models/movie.dart';

/// Dio instance with TMDB base URL and API key.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.queryParameters['api_key'] = apiKey;
      handler.next(options);
    },
  ));
  return dio;
});

/// API service for raw HTTP calls.
final movieApiServiceProvider = Provider<MovieApiService>((ref) {
  return MovieApiService(ref.watch(dioProvider));
});

/// Repository that converts API data into domain models.
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository(ref.watch(movieApiServiceProvider));
});

/// Fetches popular movies on app startup.
final popularMoviesProvider = FutureProvider<List<Movie>>((ref) {
  return ref.watch(movieRepositoryProvider).fetchPopularMovies();
});

/// Searches movies by query. Use with `.family` to pass the search term.
final movieSearchProvider = FutureProvider.family<List<Movie>, String>((ref, query) {
  return ref.watch(movieRepositoryProvider).searchMovies(query);
});

/// Fetches a single movie's details by ID.
final movieDetailProvider = FutureProvider.family<Movie, int>((ref, movieId) {
  return ref.watch(movieRepositoryProvider).fetchMovieDetail(movieId);
});
