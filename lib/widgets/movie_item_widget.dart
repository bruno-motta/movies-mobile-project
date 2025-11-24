import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/movie.dart';

class MovieItemWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const MovieItemWidget({
    super.key,
    required this.movie,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        movie.imageUrl,
        width: 60,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      ),
      title: Text(movie.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${movie.genre} • ${movie.ageRating} • ${movie.year}'),
          Row(
            children: [
              RatingBarIndicator(
                rating: movie.score,
                itemBuilder: (context, index) => const Icon(Icons.star),
                itemCount: 5,
                itemSize: 16.0,
                direction: Axis.horizontal,
              ),
              const SizedBox(width: 8),
              Text(movie.score.toStringAsFixed(1)),
            ],
          ),
        ],
      ),
      isThreeLine: true,
      onTap: onTap,
      trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
    );
  }
}
