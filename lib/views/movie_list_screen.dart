import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';
import '../views/movie_form_screen.dart';
import '../views/movie_detail_screen.dart';
import '../widgets/movie_item_widget.dart';
import '../models/movie.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final String grupoNome =
      'Grupo Exemplo - NomeDoGrupo'; // ajuste para o nome real do grupo

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MovieViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Filmes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showGroupAlert(),
            tooltip: 'Nome do grupo',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => vm.search(v),
              decoration: InputDecoration(
                hintText: 'Pesquisar título ou gênero',
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          vm.search('');
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.movies.length,
              itemBuilder: (context, index) {
                final movie = vm.movies[index];
                return Dismissible(
                  key: ValueKey(movie.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) async {
                    if (movie.id != null) {
                      await vm.deleteMovie(movie.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Filme "${movie.title}" deletado'),
                        ),
                      );
                    }
                  },
                  child: MovieItemWidget(
                    movie: movie,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MovieDetailScreen(movie: movie),
                        ),
                      );
                    },
                    onEdit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MovieFormScreen(editMovie: movie),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const MovieFormScreen())),
      ),
    );
  }

  void _showGroupAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nome do Grupo'),
        content: Text(grupoNome),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
