import 'package:flutter/material.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:lib_core/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<WatchlistMovieNotifier>(context, listen: false).fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false).fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie)),
              Tab(icon: Icon(Icons.connected_tv)),
            ],
          ),
          title: Text('Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<WatchlistMovieNotifier>(
            builder: (context, data, child) {
              if (data.watchlistState == RequestState.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.watchlistState == RequestState.loaded) {
                final watchlistMovie = data.watchlistMovies.where((item) => item.isMovie).toList();
                final watchlistTv = data.watchlistMovies.where((item) => !item.isMovie).toList();

                return TabBarView(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = watchlistMovie[index];
                        return MovieCard(movie);
                      },
                      itemCount: watchlistMovie.length,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = watchlistTv[index];
                        return MovieCard(movie);
                      },
                      itemCount: watchlistTv.length,
                    ),
                  ],
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
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
