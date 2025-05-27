class Movie {
  final String id;
  final String title;
  final String imgUrl;
  final String rating;
  final List<String> genre;
  final String duration;

  Movie({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.rating,
    required this.genre,
    required this.duration
  });

  factory Movie.fromJson(Map<String, dynamic> json) {

    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'noTitle',
      imgUrl: json['imgUrl'] ?? 'https://via.placeholder.com/600x400/CCCCCC/FFFFFF?text=No+Image',
      rating: json['rating'] ?? '',
      genre: json['genre'] != null
          ? List<String>.from(json['genre'])
          : <String>[],
      duration: json['duration'] ?? '',

    );
  }
}