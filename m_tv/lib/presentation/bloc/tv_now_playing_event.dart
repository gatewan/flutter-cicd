part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingEvent extends Equatable {
  const TvNowPlayingEvent();
}

class OnTvNowPlaying extends TvNowPlayingEvent {
  const OnTvNowPlaying();

  @override
  List<Object?> get props => [];
}
