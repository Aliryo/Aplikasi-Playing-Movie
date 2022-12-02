class Movie {
  late String title;
  late String overview;
  late String posterPath;
  late int id;
  late dynamic voteAverage;

  Movie.dariJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    overview = json['overview'] ?? '';
    posterPath = json['poster_path'] ?? '';
    voteAverage = json['vote_average'] ?? 0;
    id = json['id'];
  }
}
