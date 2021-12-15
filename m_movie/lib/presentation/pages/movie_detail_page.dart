import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lib_core/domain/entities/genre.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/utils/routes.dart';
import 'package:m_watchlist/m_watchlist.dart';

import '../../m_movie.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetail _movieDetail;

  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(OnMovieDetail(id: widget.id));
    context.read<MovieRecommendationBloc>().add(OnMovieRecommendation(id: widget.id));
    context.read<MovieWatchListBloc>().add(OnMovieStatusWatchList(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(builder: (context, state) {
        if (state is StateLoadingDetail) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is StateErrorDetail) {
          return Text(state.message);
        } else if (state is StateEmptyDetail) {
          return const Text('No available movie right now');
        } else if (state is StateMovieDetail) {
          _movieDetail = state.movieDetail;
          return SafeArea(
            child: DetailContent(_movieDetail),
          );
        } else {
          return const Text('Failed');
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  const DetailContent(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<MovieWatchListBloc, MovieWatchListState>(builder: (context, state) {
                              if (state is StateWatchListStatusMovie) {
                                debugPrint("watch list status ${state.isFavorite}");
                                return ElevatedButton(
                                  onPressed: () {
                                    if (state.isFavorite) {
                                      context
                                          .read<MovieWatchListBloc>()
                                          .add(OnMovieRemoveWatchList(movieDetail: movie));
                                    } else {
                                      context.read<MovieWatchListBloc>().add(OnMovieAddWatchList(movieDetail: movie));
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state.isFavorite ? const Icon(Icons.check) : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              } else {
                                return ElevatedButton(
                                  onPressed: () {
                                    context.read<MovieWatchListBloc>().add(OnMovieAddWatchList(movieDetail: movie));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              }
                            }),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(builder: (context, state) {
                              if (state is StateLoadingRecommendation) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is StateErrorRecommendation) {
                                return Text(state.message);
                              } else if (state is StateMovieRecommendation) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie = state.movies[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              routeDetailMovie,
                                              arguments: [movie.id],
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) => const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.movies.length,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
