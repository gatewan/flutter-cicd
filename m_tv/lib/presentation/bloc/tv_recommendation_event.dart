part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable {
  const TvRecommendationEvent();
}

class OnTvRecommendation extends TvRecommendationEvent {
  final int id;

  const OnTvRecommendation({required this.id});

  @override
  List<Object?> get props => [id];
}
