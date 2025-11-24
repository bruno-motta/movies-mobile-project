import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../repositories/movie_repository.dart';

class MovieViewModel with ChangeNotifier {
  final MovieRepository _repo = MovieRepository();
  List<Movie> movies = [];
  bool loading = false;

  Future<void> loadMovies() async {
    loading = true;
    notifyListeners();
    movies = await _repo.getAll();
    loading = false;
    notifyListeners();
  }

  Future<void> addMovie(Movie m) async {
    await _repo.add(m);
    await loadMovies();
  }

  Future<void> updateMovie(Movie m) async {
    await _repo.update(m);
    await loadMovies();
  }

  Future<void> deleteMovie(int id) async {
    await _repo.delete(id);
    await loadMovies();
  }

  Future<void> search(String q) async {
    loading = true;
    notifyListeners();
    if (q.isEmpty) {
      movies = await _repo.getAll();
    } else {
      movies = await _repo.search(q);
    }
    loading = false;
    notifyListeners();
  }
}
