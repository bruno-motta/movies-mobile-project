class Movie {
  int? id;
  String imageUrl;
  String title;
  String genre;
  String ageRating; // Livre, 10, 12, ...
  int duration; // em minutos
  double score; // 0.0 - 5.0
  String description;
  int year;

  Movie({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.ageRating,
    required this.duration,
    required this.score,
    required this.description,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'genre': genre,
      'ageRating': ageRating,
      'duration': duration,
      'score': score,
      'description': description,
      'year': year,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
    id: map['id'] as int?,
    imageUrl: map['imageUrl'],
    title: map['title'],
    genre: map['genre'],
    ageRating: map['ageRating'],
    duration: map['duration'],
    score: (map['score'] as num).toDouble(),
    description: map['description'],
    year: map['year'],
  );
}
