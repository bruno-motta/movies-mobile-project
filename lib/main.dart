import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/movie_viewmodel.dart';
import 'views/movie_list_screen.dart';

void main() {
  runApp(const FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieViewModel()..loadMovies(),
      child: MaterialApp(
        title: 'Filmes App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MovieListScreen(),
      ),
    );
  }
}
