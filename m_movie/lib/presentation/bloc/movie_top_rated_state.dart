part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();
}

class StateEmptyTopRated extends MovieTopRatedState {
  @override
  List<Object?> get props => [];
}

class StateLoadingTopRated extends MovieTopRatedState {
  @override
  List<Object?> get props => [];
}

class StateErrorTopRated extends MovieTopRatedState {
  final String message;

  const StateErrorTopRated({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateMovieTopRated extends MovieTopRatedState {
  final List<Movie> movies;

  const StateMovieTopRated({required this.movies});

  @override
  List<Object?> get props => [movies];
}
