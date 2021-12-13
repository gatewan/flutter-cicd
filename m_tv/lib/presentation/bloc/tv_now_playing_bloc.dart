import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:m_tv/domain/usecases/get_tv_now_playing.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetTvNowPlaying getNowPlayingTvs;

  TvNowPlayingBloc({required this.getNowPlayingTvs}) : super(StateEmptyNowPlaying()) {
    //fetch tv now playing
    on<OnTvNowPlaying>((event, emit) async {
      emit(StateLoadingNowPlaying());
      final result = await getNowPlayingTvs.execute();
      result.fold(
        (failure) {
          emit(StateErrorNowPlaying(message: failure.message));
        },
        (tvsData) {
          emit(StateTvNowPlaying(tvs: tvsData));
        },
      );
    });
  }
}
