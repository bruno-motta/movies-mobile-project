import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Filme')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.network(
              movie.imageUrl,
              width: 140,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 140),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${movie.genre} • ${movie.ageRating} • ${movie.year}'),
                  const SizedBox(height: 8),
                  RatingBarIndicator(
                    rating: movie.score,
                    itemBuilder: (context, index) => const Icon(Icons.star),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(height: 8),
                  Text('Duração: ${movie.duration} minutos'),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(movie.description),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
