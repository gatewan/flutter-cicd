import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/pages/watchlist_movies_page.dart';
import 'package:lib_core/presentation/provider/movie_list_notifier.dart';
import 'package:lib_core/presentation/provider/tv_list_notifier.dart';
import 'package:lib_core/utils/routes.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  bool _isMovie = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => Provider.of<MovieListNotifier>(context, listen: false)
      ..fetchNowPlayingMovies()
      ..fetchPopularMovies()
      ..fetchTopRatedMovies());

    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTvs()
      ..fetchPopularTvs()
      ..fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() {
                  _isMovie = true;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.connected_tv),
              title: Text('Tv'),
              onTap: () {
                setState(() {
                  _isMovie = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, routeAbout);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, routeSearchMovie, arguments: _isMovie);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: _buildColumn(),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              key: Key(title),
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  Column _buildColumn() {
    if (_isMovie) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing',
            style: kHeading6,
          ),
          Consumer<MovieListNotifier>(builder: (context, data, child) {
            final state = data.nowPlayingState;
            if (state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return MovieList(data.nowPlayingMovies, _isMovie);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(context, routePopularMovie, arguments: _isMovie),
          ),
          Consumer<MovieListNotifier>(builder: (context, data, child) {
            final state = data.popularMoviesState;
            if (state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return MovieList(data.popularMovies, _isMovie);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, routeTopRateMovie, arguments: _isMovie),
          ),
          Consumer<MovieListNotifier>(builder: (context, data, child) {
            final state = data.topRatedMoviesState;
            if (state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return MovieList(data.topRatedMovies, _isMovie);
            } else {
              return Text('Failed');
            }
          }),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'On The Air',
            style: kHeading6,
          ),
          Consumer<TvListNotifier>(builder: (context, data, child) {
            final state = data.nowPlayingState;
            if (state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return TvList(data.nowPlayingTvs, _isMovie);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () => Navigator.pushNamed(context, routePopularMovie, arguments: _isMovie),
          ),
          Consumer<TvListNotifier>(builder: (context, data, child) {
            final state = data.popularTvsState;
            if (state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return TvList(data.popularTvs, _isMovie);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () => Navigator.pushNamed(context, routeTopRateMovie, arguments: _isMovie),
          ),
          Consumer<TvListNotifier>(builder: (context, data, child) {
            final state = data.topRatedTvsState;
            if (state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.loaded) {
              return TvList(data.topRatedTvs, _isMovie);
            } else {
              return Text('Failed');
            }
          }),
        ],
      );
    }
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final bool isMovie;

  MovieList(this.movies, this.isMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeDetailMovie,
                  arguments: [movie.id, isMovie],
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;
  final bool isMovie;

  TvList(this.tvs, this.isMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeDetailMovie,
                  arguments: [item.id, isMovie],
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${item.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
