import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';
import '../providers/movie_providers.dart';

class MovieDetailScreen extends ConsumerWidget {
  final int movieId;
  final String title;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailProvider(movieId));

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: movieAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        data: (movie) => _buildContent(context, movie),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Movie movie) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          if (movie.fullPosterUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: movie.fullPosterUrl,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
              placeholder: (_, __) => const SizedBox(
                height: 400,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (_, __, ___) => const SizedBox(
                height: 200,
                child: Center(child: Icon(Icons.broken_image, size: 64)),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                // Rating and release date
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${movie.voteAverage.toStringAsFixed(1)} / 10',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 24),
                    if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty) ...[
                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        movie.releaseDate!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),

                // Overview
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview.isNotEmpty ? movie.overview : 'No overview available.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
