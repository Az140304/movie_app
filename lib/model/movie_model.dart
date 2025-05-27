class Movie {
  final String id;
  final String title;
  final String imgUrl;
  final String rating;
  //final List<String> genre;
  final String duration;/*
  final String description;
  final String director;
  final String cast;
  final String language;
  */

  Movie({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.rating,
    //required this.genre,
    required this.duration/*
    required this.description,
    required this.director,
    required this.cast,
    required this.language,
    */
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Safer extraction of the clan with proper null checks/
    /*
    String clanValue = "No Clan";
    if (json['personal'] != null &&
        json['personal'] is Map &&
        json['personal']['clan'] != null) {
      clanValue = "${json['personal']['clan']} Clan";
    }*/

    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'noTitle',
      imgUrl: (json['imgUrl'] != null && json['imgUrl'] is List && json['imgUrl'].isNotEmpty)
          ? json['imgUrl'][0]
          : 'https://placehold.co/600x400',
      rating: json['rating'] ?? 'asd',
      //genre: json['genre'] ?? 'asd',
      duration: json['duration'] ?? 'asd',/*
      description: json['description'] ?? '',
      director: json['director'] ?? 'unknown',
      cast: json['cast'] ?? '',
      language: json['language'] ?? '',
      */

    );
  }
}