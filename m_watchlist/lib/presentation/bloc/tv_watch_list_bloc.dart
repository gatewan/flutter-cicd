import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:m_watchlist/domain/usecases/get_tv_watchlist.dart';

import '../../m_watchlist.dart';

part 'tv_watch_list_event.dart';

part 'tv_watch_list_state.dart';

class TvWatchListBloc extends Bloc<TvWatchListEvent, TvWatchListState> {
  final GetTvWatchlist getWatchlistTvs;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TvWatchListBloc({
    required this.getWatchlistTvs,
    required this.getTvWatchListStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  }) : super(StateEmptyTvWatchList()) {
    on<OnTvWatchList>((event, emit) async {
      emit(StateLoadingTvWatchList());
      final result = await getWatchlistTvs.execute();
      result.fold(
        (failure) {
          emit(StateErrorTvWatchList(message: failure.message));
        },
        (data) {
          emit(StateTvWatchList(tvs: data));
        },
      );
    });
    //watchlist status
    on<OnTvStatusWatchList>((event, emit) async {
      emit(StateLoadingTvWatchList());
      final result = await getTvWatchListStatus.execute(event.id);
      emit(StateWatchListStatusTv(isFavorite: result));
    });
    //watchlist add
    on<OnTvAddWatchList>((event, emit) async {
      emit(StateLoadingTvWatchList());
      final result = await saveTvWatchlist.execute(event.tvDetail);
      final isBookmarked = await getTvWatchListStatus.execute(event.tvDetail.id);
      final tvs = await getWatchlistTvs.execute();
      result.fold(
        (failure) {
          emit(StateErrorTvWatchList(message: failure.message));
        },
        (message) {
          tvs.fold(
            (failure) {
              emit(StateErrorTvWatchList(message: failure.message));
            },
            (data) {
              emit(StateTvWatchList(tvs: data));
              emit(StateWatchListStatusTv(isFavorite: isBookmarked));
            },
          );
        },
      );
    });
    //watchlist remove
    on<OnTvRemoveWatchList>((event, emit) async {
      emit(StateLoadingTvWatchList());
      final result = await removeTvWatchlist.execute(event.tvDetail);
      final isBookmarked = await getTvWatchListStatus.execute(event.tvDetail.id);
      final tvs = await getWatchlistTvs.execute();
      result.fold(
        (failure) {
          emit(StateErrorTvWatchList(message: failure.message));
        },
        (message) {
          tvs.fold(
            (failure) {
              emit(StateErrorTvWatchList(message: failure.message));
            },
            (data) {
              emit(StateTvWatchList(tvs: data));
              emit(StateWatchListStatusTv(isFavorite: isBookmarked));
            },
          );
        },
      );
    });
  }
}
