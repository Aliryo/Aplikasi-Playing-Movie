import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_movie_api/models/list_movie_model.dart';
import 'package:new_movie_api/pages/movie_detail_page.dart';
import 'package:new_movie_api/services/movie_service.dart';
import 'package:new_movie_api/widgets/error_widget.dart';

class ResultMoviePage extends StatefulWidget {
  String search = '';

  ResultMoviePage(String value) {
    search = value;
  }

  @override
  State<ResultMoviePage> createState() => _ResultMoviePageState();
}

class _ResultMoviePageState extends State<ResultMoviePage> {
  MovieServices svc = MovieServices();
  bool isSearching = false;
  bool isList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isSearching
            ? TextFormField(
                onFieldSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultMoviePage(value),
                    ),
                  );
                  //Navigator.popAndPushNamed(context, 'resultpage', arguments: value);
                },
                cursorColor: Colors.white,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration.collapsed(
                  hintText: 'Search Movie...',
                  hintStyle: GoogleFonts.poppins(color: Colors.white),
                ),
              )
            : Text(
                'Result: ${widget.search}',
                style: GoogleFonts.poppins(),
              ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              child: isSearching
                  ? const Icon(Icons.cancel)
                  : const Icon(Icons.search),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 12, left: 0, top: 12, bottom: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isList = !isList;
                });
              },
              child: isList
                  ? const Icon(
                      Icons.grid_view,
                    )
                  : const Icon(Icons.list),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        color: Colors.yellow,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<ListMovie>(
          future: svc.searchMovie(widget.search),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return isList
                  ? ListView.builder(
                      itemCount: data!.results.length,
                      itemBuilder: (context, index) {
                        var movie = data.results[index];
                        return InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          splashColor: Colors.yellow,
                          onTap: () {
                            var idmovie = movie.id.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(idmovie),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 8,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide:
                                  const BorderSide(color: Colors.yellowAccent),
                            ),
                            margin: const EdgeInsets.all(12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      placeholder: (context, s) {
                                        return const CircularProgressIndicator(
                                          color: Colors.yellow,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        movie.title,
                                        style: GoogleFonts.arvo(fontSize: 25),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        movie.overview,
                                        style: GoogleFonts.arvo(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: data!.results.length,
                      itemBuilder: (context, index) {
                        var movie = data.results[index];
                        return InkWell(
                          splashColor: Colors.yellow,
                          onTap: () {
                            var idmovie = movie.id.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(idmovie),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 8,
                            shape: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.yellowAccent),
                            ),
                            child: GridTile(
                              footer: GridTileBar(
                                backgroundColor: Colors.black54,
                                leading: const Icon(Icons.favorite),
                                title: Text(
                                  movie.title,
                                  style: GoogleFonts.arvo(),
                                ),
                                trailing: const Icon(Icons.share),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                placeholder: (context, s) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.yellow,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      });
            } else if (snapshot.hasError) {
              return NoInternet(
                message:
                    'Failed to load, make sure you have internet connection.\n\n\n${snapshot.error}',
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
