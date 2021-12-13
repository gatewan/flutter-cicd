part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();
}

class StateEmptyRecommendation extends TvRecommendationState {
  @override
  List<Object?> get props => [];
}

class StateLoadingRecommendation extends TvRecommendationState {
  @override
  List<Object?> get props => [];
}

class StateErrorRecommendation extends TvRecommendationState {
  final String message;

  const StateErrorRecommendation({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateTvRecommendation extends TvRecommendationState {
  final List<Tv> tvs;

  const StateTvRecommendation({required this.tvs});

  @override
  List<Object?> get props => [tvs];
}
