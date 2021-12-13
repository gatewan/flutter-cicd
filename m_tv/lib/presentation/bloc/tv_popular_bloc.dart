import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:m_tv/domain/usecases/get_tv_popular.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetTvPopular getPopularTvs;

  TvPopularBloc({required this.getPopularTvs}) : super(StateEmptyPopular()) {
    //fetch tv popular
    on<OnTvPopular>((event, emit) async {
      emit(StateLoadingPopular());
      final result = await getPopularTvs.execute();
      result.fold(
        (failure) {
          emit(StateErrorPopular(message: failure.message));
        },
        (tvsData) {
          emit(StateTvPopular(tvs: tvsData));
        },
      );
    });
  }
}
