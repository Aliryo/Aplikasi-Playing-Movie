import 'package:new_movie_api/models/movie_model.dart';

class ListMovie {
  late int page;

  late List<Movie> results = [];

  ListMovie.dariJson(Map<String, dynamic> json) {
    page = json['page'];

    json['results'].forEach((m) {
      Movie mv = Movie.dariJson(m);
      results.add(mv);
      //mengambil data dari setiap movie satu per satu sampai habis
    });
  }
}
