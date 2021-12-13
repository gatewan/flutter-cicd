import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/widgets/movie_card_list.dart';
import 'package:m_movie/m_movie.dart';
import 'package:provider/provider.dart';

class MovieTopRatedPage extends StatefulWidget {
  const MovieTopRatedPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<MovieTopRatedPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieTopRatedBloc>().add(const OnMovieTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(builder: (context, state) {
          if (state is StateLoadingTopRated) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorTopRated) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else if (state is StateMovieTopRated) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else {
            return const Center();
          }
        }),
      ),
    );
  }
}
