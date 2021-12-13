part of 'tv_watch_list_bloc.dart';

abstract class TvWatchListEvent extends Equatable {
  const TvWatchListEvent();
}

class OnTvWatchList extends TvWatchListEvent {
  @override
  List<Object?> get props => [];
}

class OnTvStatusWatchList extends TvWatchListEvent {
  final int id;

  const OnTvStatusWatchList({required this.id});

  @override
  List<Object?> get props => [id];
}

class OnTvAddWatchList extends TvWatchListEvent {
  final TvDetail tvDetail;

  const OnTvAddWatchList({required this.tvDetail});

  @override
  List<Object?> get props => [tvDetail];
}

class OnTvRemoveWatchList extends TvWatchListEvent {
  final TvDetail tvDetail;

  const OnTvRemoveWatchList({required this.tvDetail});

  @override
  List<Object?> get props => [tvDetail];
}
