part of 'movie_popular_bloc.dart';

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();
}

class OnMoviePopular extends MoviePopularEvent {
  const OnMoviePopular();

  @override
  List<Object?> get props => [];
}
