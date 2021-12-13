import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:m_tv/domain/usecases/get_tv_recommendations.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationBloc({required this.getTvRecommendations}) : super(StateEmptyRecommendation()) {
    //fetch tv recommendation
    on<OnTvRecommendation>((event, emit) async {
      emit(StateLoadingRecommendation());
      final result = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(StateErrorRecommendation(message: failure.message));
        },
        (tvsData) {
          emit(StateTvRecommendation(tvs: tvsData));
        },
      );
    });
  }
}
