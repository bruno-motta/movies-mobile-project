import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/movie.dart';
import '../viewmodels/movie_viewmodel.dart';

class MovieFormScreen extends StatefulWidget {
  final Movie? editMovie;
  const MovieFormScreen({super.key, this.editMovie});

  @override
  State<MovieFormScreen> createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageController = TextEditingController();
  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _durationController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _ageRating = 'Livre';
  double _score = 3.0;

  final List<String> ageOptions = ['Livre', '10', '12', '14', '16', '18'];

  @override
  void initState() {
    super.initState();
    if (widget.editMovie != null) {
      final m = widget.editMovie!;
      _imageController.text = m.imageUrl;
      _titleController.text = m.title;
      _genreController.text = m.genre;
      _durationController.text = m.duration.toString();
      _yearController.text = m.year.toString();
      _descriptionController.text = m.description;
      _ageRating = m.ageRating;
      _score = m.score;
    }
  }

  @override
  void dispose() {
    _imageController.dispose();
    _titleController.dispose();
    _genreController.dispose();
    _durationController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MovieViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editMovie == null ? 'Cadastrar Filme' : 'Editar Filme',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe a URL da imagem' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o título' : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe o gênero' : null,
              ),
              DropdownButtonFormField<String>(
                value: _ageRating,
                items: ageOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _ageRating = v ?? _ageRating),
                decoration: const InputDecoration(labelText: 'Faixa Etária'),
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duração (minutos)',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a duração';
                  final n = int.tryParse(v);
                  if (n == null || n <= 0) return 'Informe uma duração válida';
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o ano';
                  final n = int.tryParse(v);
                  if (n == null || n < 1800) return 'Ano inválido';
                  return null;
                },
              ),

              const SizedBox(height: 12),
              const Text('Pontuação (0 a 5)'),

              /// ✅ NOVO RATING
              RatingBar.builder(
                initialRating: _score,
                minRating: 0,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 32,
                direction: Axis.horizontal,
                itemBuilder: (context, _) => const Icon(Icons.star),
                onRatingUpdate: (value) {
                  setState(() => _score = value);
                },
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 5,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe a descrição' : null,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.editMovie == null ? 'Salvar' : 'Atualizar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final movie = Movie(
                      id: widget.editMovie?.id,
                      imageUrl: _imageController.text.trim(),
                      title: _titleController.text.trim(),
                      genre: _genreController.text.trim(),
                      ageRating: _ageRating,
                      duration: int.parse(_durationController.text.trim()),
                      score: _score.clamp(0.0, 5.0),
                      description: _descriptionController.text.trim(),
                      year: int.parse(_yearController.text.trim()),
                    );

                    if (widget.editMovie == null) {
                      await vm.addMovie(movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filme cadastrado')),
                      );
                    } else {
                      await vm.updateMovie(movie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filme atualizado')),
                      );
                    }

                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
