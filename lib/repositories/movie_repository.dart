import '../data/db_helper.dart';
import '../models/movie.dart';

class MovieRepository {
  final DBHelper _db = DBHelper.instance;

  Future<Movie> add(Movie m) => _db.insertMovie(m);
  Future<List<Movie>> getAll() => _db.getAllMovies();
  Future<int> update(Movie m) => _db.updateMovie(m);
  Future<int> delete(int id) => _db.deleteMovie(id);
  Future<List<Movie>> search(String q) => _db.searchMovies(q);
}
