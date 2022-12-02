import 'package:http/http.dart' as http;
import 'package:new_movie_api/constant/config.dart';
import 'dart:convert';

import 'package:new_movie_api/models/list_movie_model.dart';
import 'package:new_movie_api/models/movie_model.dart';

class MovieServices {
  Future<ListMovie> getMovie() async {
    var uri = Uri.https(BASE_URL_MOVIEDB, '/3/movie/now_playing', {
      'api_key': API_KEY, 'language': 'en-US', 'page': '1',
      //insert more here misal region
    });

    var response = await http.get(uri);
    var result = jsonDecode(response.body);
    //var result = json.decode(response.body);

    ListMovie mv = ListMovie.dariJson(result);
    return mv;
  }

  Future<Movie> getDetailMovie(id) async {
    var uri = Uri.https(BASE_URL_MOVIEDB, '/3/movie/' + id, {
      'api_key': API_KEY,
    });
    var response = await http.get(uri);
    var result = jsonDecode(response.body);

    Movie mv = Movie.dariJson(result);
    return mv;
  }

  Future<ListMovie> searchMovie(search) async {
    var uri = Uri.https(BASE_URL_MOVIEDB, '/3/search/movie',
        {'api_key': API_KEY, 'query': search});

    var response = await http.get(uri);
    var result = jsonDecode(response.body);
    //var result = json.decode(response.body);

    ListMovie mv = ListMovie.dariJson(result);
    return mv;
  }
}
