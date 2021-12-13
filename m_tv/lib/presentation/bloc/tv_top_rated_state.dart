part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();
}

class StateEmptyTopRated extends TvTopRatedState {
  @override
  List<Object?> get props => [];
}

class StateLoadingTopRated extends TvTopRatedState {
  @override
  List<Object?> get props => [];
}

class StateErrorTopRated extends TvTopRatedState {
  final String message;

  const StateErrorTopRated({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateTvTopRated extends TvTopRatedState {
  final List<Tv> tvs;

  const StateTvTopRated({required this.tvs});

  @override
  List<Object?> get props => [tvs];
}
