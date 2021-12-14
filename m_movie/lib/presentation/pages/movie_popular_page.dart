import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lib_core/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

import '../../m_movie.dart';

class MoviePopularPage extends StatefulWidget {
  const MoviePopularPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<MoviePopularPage> {
  @override
  void initState() {
    super.initState();
    context.read<MoviePopularBloc>().add(const OnMoviePopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(builder: (context, state) {
          if (state is StateLoadingPopular) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateErrorPopular) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is StateMoviePopular) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else {
            return const Text('Failed');
          }
        }),
      ),
    );
  }
}
