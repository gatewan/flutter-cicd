part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();
}

class StateEmptyNowPlaying extends TvNowPlayingState {
  @override
  List<Object?> get props => [];
}

class StateLoadingNowPlaying extends TvNowPlayingState {
  @override
  List<Object?> get props => [];
}

class StateErrorNowPlaying extends TvNowPlayingState {
  final String message;

  const StateErrorNowPlaying({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateTvNowPlaying extends TvNowPlayingState {
  final List<Tv> tvs;

  const StateTvNowPlaying({required this.tvs});

  @override
  List<Object?> get props => [tvs];
}
