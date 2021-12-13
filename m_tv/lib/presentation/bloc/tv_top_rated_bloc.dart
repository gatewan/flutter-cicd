import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:m_tv/domain/usecases/get_tv_top_rated.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTvTopRated getTopRatedTvs;

  TvTopRatedBloc({required this.getTopRatedTvs}) : super(StateEmptyTopRated()) {
    //fetch tv top rated
    on<OnTvTopRated>((event, emit) async {
      emit(StateLoadingTopRated());
      final result = await getTopRatedTvs.execute();
      result.fold(
        (failure) {
          emit(StateErrorTopRated(message: failure.message));
        },
        (tvsData) {
          emit(StateTvTopRated(tvs: tvsData));
        },
      );
    });
  }
}
