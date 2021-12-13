import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/widgets/movie_card_list.dart';
import 'package:m_watchlist/m_watchlist.dart';
import 'package:provider/provider.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchListPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<MovieWatchListBloc>().add(OnMovieWatchList());
    context.read<TvWatchListBloc>().add(OnTvWatchList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<MovieWatchListBloc>().add(OnMovieWatchList());
    context.read<TvWatchListBloc>().add(OnTvWatchList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie)),
              Tab(icon: Icon(Icons.connected_tv)),
            ],
          ),
          title: const Text('Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              BlocBuilder<MovieWatchListBloc, MovieWatchListState>(builder: (context, state) {
                if (state is StateLoadingMovieWatchList) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StateErrorMovieWatchList) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else if (state is StateMovieWatchList) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.movies.where((item) => item.isMovie).toList()[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.movies.where((item) => item.isMovie).toList().length,
                  );
                } else {
                  return const Center(
                    child: Text('data not found!'),
                  );
                }
              }),
              BlocBuilder<TvWatchListBloc, TvWatchListState>(builder: (context, state) {
                if (state is StateLoadingTvWatchList) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is StateErrorTvWatchList) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else if (state is StateTvWatchList) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.tvs.where((item) => !item.isMovie).toList()[index];
                      return TvCard(tv);
                    },
                    itemCount: state.tvs.where((item) => !item.isMovie).toList().length,
                  );
                } else {
                  return const Center(
                    child: Text('data not found!'),
                  );
                }
              }),
            ],
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
