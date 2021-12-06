import 'package:flutter/material.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:lib_core/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:lib_core/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';
  final bool isMovie;

  TopRatedMoviesPage({required this.isMovie});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.isMovie
        ? Provider.of<TopRatedMoviesNotifier>(context, listen: false).fetchTopRatedMovies()
        : Provider.of<TopRatedTvsNotifier>(context, listen: false).fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.isMovie
            ? Consumer<TopRatedMoviesNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = data.movies[index];
                        return MovieCard(movie);
                      },
                      itemCount: data.movies.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              )
            : Consumer<TopRatedTvsNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tv = data.tvs[index];
                        final movie = Movie(
                          adult: true,
                          backdropPath: tv.backdropPath,
                          genreIds: tv.genreIds,
                          id: tv.id,
                          originalTitle: tv.originalName,
                          overview: tv.overview,
                          popularity: tv.popularity,
                          posterPath: tv.posterPath,
                          releaseDate: tv.firstAirDate,
                          title: tv.name,
                          video: false,
                          voteAverage: tv.voteAverage,
                          voteCount: tv.voteCount,
                          isMovie: false,
                        );
                        return MovieCard(movie);
                      },
                      itemCount: data.tvs.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
      ),
    );
  }
}
