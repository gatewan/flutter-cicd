part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();
}

class StateEmptyNowPlaying extends MovieNowPlayingState {
  @override
  List<Object?> get props => [];
}

class StateLoadingNowPlaying extends MovieNowPlayingState {
  @override
  List<Object?> get props => [];
}

class StateErrorNowPlaying extends MovieNowPlayingState {
  final String message;

  const StateErrorNowPlaying({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateMovieNowPlaying extends MovieNowPlayingState {
  final List<Movie> movies;

  const StateMovieNowPlaying({required this.movies});

  @override
  List<Object?> get props => [movies];
}
