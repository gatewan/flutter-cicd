part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();
}

class StateEmptyPopular extends MoviePopularState {
  @override
  List<Object?> get props => [];
}

class StateLoadingPopular extends MoviePopularState {
  @override
  List<Object?> get props => [];
}

class StateErrorPopular extends MoviePopularState {
  final String message;

  const StateErrorPopular({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateMoviePopular extends MoviePopularState {
  final List<Movie> movies;

  const StateMoviePopular({required this.movies});

  @override
  List<Object?> get props => [movies];
}
