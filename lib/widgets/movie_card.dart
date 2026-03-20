import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // Poster thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: movie.fullPosterUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: movie.fullPosterUrl,
                        width: 60,
                        height: 90,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const SizedBox(
                          width: 60,
                          height: 90,
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                        errorWidget: (_, __, ___) => _posterPlaceholder(),
                      )
                    : _posterPlaceholder(),
              ),
              const SizedBox(width: 12),
              // Title and info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty)
                      Text(
                        movie.releaseDate!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              // Rating
              Column(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(height: 2),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _posterPlaceholder() {
    return Container(
      width: 60,
      height: 90,
      color: Colors.grey[300],
      child: const Icon(Icons.movie, color: Colors.grey),
    );
  }
}
