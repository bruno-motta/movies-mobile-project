import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/movie.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('filmes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imageUrl TEXT NOT NULL,
        title TEXT NOT NULL,
        genre TEXT NOT NULL,
        ageRating TEXT NOT NULL,
        duration INTEGER NOT NULL,
        score REAL NOT NULL,
        description TEXT NOT NULL,
        year INTEGER NOT NULL
      )
    ''');

    // 🎬 Inserindo filmes iniciais no banco
    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/81p+xe8cbnL._AC_SL1500_.jpg',
      'title': 'Inception',
      'genre': 'Ficção Científica',
      'ageRating': '14',
      'duration': 148,
      'score': 9.0,
      'description':
          'Um ladrão invade os sonhos das pessoas para roubar segredos corporativos e enfrenta uma missão quase impossível: plantar uma ideia na mente de alguém.',
      'year': 2010,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/71xZPqQzGOL._AC_SL1024_.jpg',
      'title': 'O Poderoso Chefão',
      'genre': 'Drama / Crime',
      'ageRating': '16',
      'duration': 175,
      'score': 9.2,
      'description':
          'A saga da família Corleone, uma das mais poderosas máfias italianas de Nova York.',
      'year': 1972,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/91kFYg4fX3L._AC_SL1500_.jpg',
      'title': 'Interestelar',
      'genre': 'Ficção Científica',
      'ageRating': '10',
      'duration': 169,
      'score': 8.6,
      'description':
          'Um grupo de astronautas viaja por um buraco de minhoca em busca de um novo lar para a humanidade.',
      'year': 2014,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/81ExhpBEbHL._AC_SL1500_.jpg',
      'title': 'Vingadores: Ultimato',
      'genre': 'Ação / Aventura',
      'ageRating': '12',
      'duration': 181,
      'score': 8.4,
      'description':
          'Os Vingadores restantes unem forças para reverter o estalo de Thanos e restaurar o universo.',
      'year': 2019,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/71Kk9LBxOIL._AC_SL1024_.jpg',
      'title': 'Coringa',
      'genre': 'Drama / Suspense',
      'ageRating': '16',
      'duration': 122,
      'score': 8.5,
      'description':
          'Um comediante fracassado é levado à loucura e se transforma no icônico vilão de Gotham.',
      'year': 2019,
    });

    await db.insert('movies', {
      'imageUrl': 'https://m.media-amazon.com/images/I/51EG732BV3L._AC_.jpg',
      'title': 'Matrix',
      'genre': 'Ficção Científica / Ação',
      'ageRating': '14',
      'duration': 136,
      'score': 8.7,
      'description':
          'Um hacker descobre que o mundo em que vive é uma simulação controlada por máquinas.',
      'year': 1999,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/71VZLDSbFjL._AC_SL1181_.jpg',
      'title': 'Gladiador',
      'genre': 'Ação / Drama',
      'ageRating': '16',
      'duration': 155,
      'score': 8.5,
      'description':
          'Um general romano é traído e busca vingança contra o imperador corrupto que matou sua família.',
      'year': 2000,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/91xHn+ePH-L._AC_SL1500_.jpg',
      'title': 'O Senhor dos Anéis: O Retorno do Rei',
      'genre': 'Fantasia / Aventura',
      'ageRating': '12',
      'duration': 201,
      'score': 9.0,
      'description':
          'A batalha final pela Terra-média enquanto Frodo e Sam tentam destruir o Um Anel.',
      'year': 2003,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/81D+KJkO9-L._AC_SL1500_.jpg',
      'title': 'Clube da Luta',
      'genre': 'Drama / Suspense',
      'ageRating': '18',
      'duration': 139,
      'score': 8.8,
      'description':
          'Um homem insatisfeito com a vida corporativa funda um clube secreto de lutas.',
      'year': 1999,
    });

    await db.insert('movies', {
      'imageUrl':
          'https://m.media-amazon.com/images/I/71niXI3lxlL._AC_SL1181_.jpg',
      'title': 'Forrest Gump',
      'genre': 'Drama / Romance',
      'ageRating': '10',
      'duration': 142,
      'score': 8.8,
      'description':
          'A história de um homem simples com um coração puro que vivencia grandes momentos da história americana.',
      'year': 1994,
    });
  }

  Future<Movie> insertMovie(Movie movie) async {
    final db = await instance.database;
    final id = await db.insert('movies', movie.toMap());
    movie.id = id;
    return movie;
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await instance.database;
    final orderBy = 'title ASC';
    final result = await db.query('movies', orderBy: orderBy);
    return result.map((e) => Movie.fromMap(e)).toList();
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await instance.database;
    return db.update(
      'movies',
      movie.toMap(),
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await instance.database;
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'movies',
      where: 'title LIKE ? OR genre LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return result.map((e) => Movie.fromMap(e)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
