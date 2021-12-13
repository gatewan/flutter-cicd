import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:m_tv/domain/usecases/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;

  TvDetailBloc({required this.getTvDetail}) : super(StateEmptyDetail()) {
    //fetch tv detail
    on<OnTvDetail>((event, emit) async {
      emit(StateLoadingDetail());
      final result = await getTvDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(StateErrorDetail(message: failure.message));
        },
        (tvsData) {
          emit(StateTvDetail(tvDetail: tvsData));
        },
      );
    });
  }
}
