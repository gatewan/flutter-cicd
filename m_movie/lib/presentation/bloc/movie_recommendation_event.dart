part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();
}

class OnMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  const OnMovieRecommendation({required this.id});

  @override
  List<Object?> get props => [id];
}
