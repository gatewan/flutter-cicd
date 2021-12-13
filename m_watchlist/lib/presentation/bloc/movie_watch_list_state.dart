part of 'movie_watch_list_bloc.dart';

abstract class MovieWatchListState extends Equatable {
  const MovieWatchListState();
}

class StateEmptyMovieWatchList extends MovieWatchListState {
  @override
  List<Object?> get props => [];
}

class StateLoadingMovieWatchList extends MovieWatchListState {
  @override
  List<Object?> get props => [];
}

class StateErrorMovieWatchList extends MovieWatchListState {
  final String message;

  const StateErrorMovieWatchList({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateMovieWatchList extends MovieWatchListState {
  final List<Movie> movies;

  const StateMovieWatchList({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class StateWatchListStatusMovie extends MovieWatchListState {
  final bool isFavorite;

  const StateWatchListStatusMovie({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}
