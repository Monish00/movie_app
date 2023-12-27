class MoviesList {
  final int id;
  final String language;
  final String orginalTitle;
  final String overView;
  final String poster;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  MoviesList({
    required this.id,
    required this.language,
    required this.orginalTitle,
    required this.overView,
    required this.poster,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MoviesList.fromJson(Map<String, dynamic> parsedJson) {
    return MoviesList(
      id: parsedJson['id'],
      language: parsedJson['original_language'],
      orginalTitle: parsedJson['original_title'],
      overView: parsedJson['overview'],
      poster: parsedJson['poster_path'],
      releaseDate: parsedJson['release_date'],
      title: parsedJson['title'],
      voteAverage: parsedJson['vote_average'],
      voteCount: parsedJson['vote_count'],
    );
  }

  MoviesList.fromMap(Map<String, dynamic> item)
      : id = item['id'],
        language = item['originalLanguage'],
        orginalTitle = item['originalTitle'],
        overView = item['overView'],
        poster = item['poster'],
        releaseDate = item['releaseDate'],
        title = item['title'],
        voteAverage = item['voteAverage'],
        voteCount = item['voteCount'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'language': language,
      'orginalTitle': orginalTitle,
      'overView': overView,
      'poster': poster,
      'releaseDate': releaseDate,
      'title': title,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }
}
