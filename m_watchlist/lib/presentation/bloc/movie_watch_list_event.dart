part of 'movie_watch_list_bloc.dart';

abstract class MovieWatchListEvent extends Equatable {
  const MovieWatchListEvent();
}

class OnMovieWatchList extends MovieWatchListEvent {
  @override
  List<Object?> get props => [];
}

class OnMovieStatusWatchList extends MovieWatchListEvent {
  final int id;

  const OnMovieStatusWatchList({required this.id});

  @override
  List<Object?> get props => [id];
}

class OnMovieAddWatchList extends MovieWatchListEvent {
  final MovieDetail movieDetail;

  const OnMovieAddWatchList({required this.movieDetail});

  @override
  List<Object?> get props => [movieDetail];
}

class OnMovieRemoveWatchList extends MovieWatchListEvent {
  final MovieDetail movieDetail;

  const OnMovieRemoveWatchList({required this.movieDetail});

  @override
  List<Object?> get props => [movieDetail];
}
