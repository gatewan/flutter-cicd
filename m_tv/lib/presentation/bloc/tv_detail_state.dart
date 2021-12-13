part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();
}

class StateEmptyDetail extends TvDetailState {
  @override
  List<Object?> get props => [];
}

class StateLoadingDetail extends TvDetailState {
  @override
  List<Object?> get props => [];
}

class StateErrorDetail extends TvDetailState {
  final String message;

  const StateErrorDetail({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateTvDetail extends TvDetailState {
  final TvDetail tvDetail;

  const StateTvDetail({required this.tvDetail});

  @override
  List<Object?> get props => [tvDetail];
}
