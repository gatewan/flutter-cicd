part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();
}

class StateEmptyPopular extends TvPopularState {
  @override
  List<Object?> get props => [];
}

class StateLoadingPopular extends TvPopularState {
  @override
  List<Object?> get props => [];
}

class StateErrorPopular extends TvPopularState {
  final String message;

  const StateErrorPopular({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateTvPopular extends TvPopularState {
  final List<Tv> tvs;

  const StateTvPopular({required this.tvs});

  @override
  List<Object?> get props => [tvs];
}
