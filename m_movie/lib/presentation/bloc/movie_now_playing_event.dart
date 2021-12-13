part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();
}

class OnMovieNowPlaying extends MovieNowPlayingEvent {
  const OnMovieNowPlaying();

  @override
  List<Object?> get props => [];
}
