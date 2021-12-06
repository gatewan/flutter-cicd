import 'package:flutter/material.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/popular_movies_notifier.dart';
import 'package:lib_core/presentation/provider/popular_tv_notifier.dart';
import 'package:lib_core/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';
  final bool isMovie;

  PopularMoviesPage({required this.isMovie});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.isMovie
        ? Provider.of<PopularMoviesNotifier>(context, listen: false).fetchPopularMovies()
        : Provider.of<PopularTvsNotifier>(context, listen: false).fetchPopularTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.isMovie
            ? Consumer<PopularMoviesNotifier>(
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
            : Consumer<PopularTvsNotifier>(
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
