part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();
}

class OnMovieTopRated extends MovieTopRatedEvent {
  const OnMovieTopRated();

  @override
  List<Object?> get props => [];
}
