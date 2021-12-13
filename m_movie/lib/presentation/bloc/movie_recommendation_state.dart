part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();
}

class StateEmptyRecommendation extends MovieRecommendationState {
  @override
  List<Object?> get props => [];
}

class StateLoadingRecommendation extends MovieRecommendationState {
  @override
  List<Object?> get props => [];
}

class StateErrorRecommendation extends MovieRecommendationState {
  final String message;

  const StateErrorRecommendation({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateMovieRecommendation extends MovieRecommendationState {
  final List<Movie> movies;

  const StateMovieRecommendation({required this.movies});

  @override
  List<Object?> get props => [movies];
}
