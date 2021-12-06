import 'package:flutter/material.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/movie_search_notifier.dart';
import 'package:lib_core/presentation/provider/tv_search_notifier.dart';
import 'package:lib_core/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final bool isMovie;

  SearchPage({required this.isMovie});

  @override
  Widget build(BuildContext context) {
    debugPrint('wtf search $isMovie');
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                isMovie
                    ? Provider.of<MovieSearchNotifier>(context, listen: false).fetchMovieSearch(query)
                    : Provider.of<TvSearchNotifier>(context, listen: false).fetchTvSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isMovie
                ? Consumer<MovieSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.loaded) {
                        final result = data.searchResult;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = data.searchResult[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : Consumer<TvSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.loaded) {
                        final result = data.searchResult;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = data.searchResult[index];
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
                                isMovie: isMovie,
                              );
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
