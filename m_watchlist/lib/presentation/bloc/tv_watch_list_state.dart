part of 'tv_watch_list_bloc.dart';

abstract class TvWatchListState extends Equatable {
  const TvWatchListState();
}

class StateEmptyTvWatchList extends TvWatchListState {
  @override
  List<Object?> get props => [];
}

class StateLoadingTvWatchList extends TvWatchListState {
  @override
  List<Object?> get props => [];
}

class StateErrorTvWatchList extends TvWatchListState {
  final String message;

  const StateErrorTvWatchList({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateTvWatchList extends TvWatchListState {
  final List<Tv> tvs;

  const StateTvWatchList({required this.tvs});

  @override
  List<Object?> get props => [tvs];
}

class StateWatchListStatusTv extends TvWatchListState {
  final bool isFavorite;

  const StateWatchListStatusTv({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}
