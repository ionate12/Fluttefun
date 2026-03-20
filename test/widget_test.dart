import 'package:flutter_test/flutter_test.dart';
import 'package:movie_ratings/models/movie.dart';

void main() {
  group('Movie model', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 123,
        'title': 'Test Movie',
        'overview': 'A great movie.',
        'poster_path': '/abc.jpg',
        'vote_average': 8.5,
        'release_date': '2024-01-15',
      };

      final movie = Movie.fromJson(json);

      expect(movie.id, 123);
      expect(movie.title, 'Test Movie');
      expect(movie.overview, 'A great movie.');
      expect(movie.posterPath, '/abc.jpg');
      expect(movie.voteAverage, 8.5);
      expect(movie.releaseDate, '2024-01-15');
      expect(movie.fullPosterUrl, 'https://image.tmdb.org/t/p/w500/abc.jpg');
    });

    test('fromJson handles null poster', () {
      final json = {
        'id': 456,
        'title': 'No Poster',
        'overview': '',
        'poster_path': null,
        'vote_average': 0,
        'release_date': null,
      };

      final movie = Movie.fromJson(json);

      expect(movie.posterPath, isNull);
      expect(movie.fullPosterUrl, '');
    });
  });
}
