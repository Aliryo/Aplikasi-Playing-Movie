import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_movie_api/models/movie_model.dart';
import 'package:new_movie_api/widgets/custom_button.dart';
import 'package:new_movie_api/services/movie_service.dart';
import 'package:new_movie_api/widgets/error_widget.dart';

class MovieDetailPage extends StatefulWidget {
  var idnya = '';
  MovieDetailPage(String id) {
    idnya = id.toString();
  }

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieServices svc = MovieServices();

  @override
  Widget build(BuildContext context) {
    //var idnya = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: RefreshIndicator(
        color: Colors.yellow,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<Movie>(
          future: svc.getDetailMovie(widget.idnya),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movie = snapshot.data;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movie!.posterPath}',
                    fit: BoxFit.fill,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      children: [
                        Container(
                          width: double.infinity,
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 100,
                                offset: Offset(0, 20),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              movie.title,
                              style: GoogleFonts.arvo(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: Colors.yellow[600],
                                ),
                                Text(
                                  '${movie.voteAverage}/10',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            movie.overview,
                            style: GoogleFonts.arvo(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              width: 200,
                              child: Text(
                                'Rate Now',
                                style: GoogleFonts.arvo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            const CustomButton(
                              width: 80,
                              child: Icon(Icons.share),
                            ),
                            const CustomButton(
                              width: 80,
                              child: Icon(Icons.bookmark),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
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
