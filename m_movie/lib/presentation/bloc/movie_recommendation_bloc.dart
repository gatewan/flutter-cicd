import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc({required this.getMovieRecommendations}) : super(StateEmptyRecommendation()) {
    //fetch movie recommendation
    on<OnMovieRecommendation>((event, emit) async {
      emit(StateLoadingRecommendation());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(StateErrorRecommendation(message: failure.message));
        },
        (moviesData) {
          emit(StateMovieRecommendation(movies: moviesData));
        },
      );
    });
  }
}
