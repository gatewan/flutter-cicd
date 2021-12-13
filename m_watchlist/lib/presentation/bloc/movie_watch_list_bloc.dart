import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';

import '../../m_watchlist.dart';

part 'movie_watch_list_event.dart';

part 'movie_watch_list_state.dart';

class MovieWatchListBloc extends Bloc<MovieWatchListEvent, MovieWatchListState> {
  final GetMovieWatchlist getWatchlistMovies;
  final GetMovieWatchListStatus getMovieWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  MovieWatchListBloc({
    required this.getWatchlistMovies,
    required this.getMovieWatchListStatus,
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
  }) : super(StateEmptyMovieWatchList()) {
    on<OnMovieWatchList>((event, emit) async {
      emit(StateLoadingMovieWatchList());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(StateErrorMovieWatchList(message: failure.message));
        },
        (data) {
          emit(StateMovieWatchList(movies: data));
        },
      );
    });
    //watchlist status
    on<OnMovieStatusWatchList>((event, emit) async {
      emit(StateLoadingMovieWatchList());
      final result = await getMovieWatchListStatus.execute(event.id);
      emit(StateWatchListStatusMovie(isFavorite: result));
    });
    //watchlist add
    on<OnMovieAddWatchList>((event, emit) async {
      emit(StateLoadingMovieWatchList());
      final result = await saveMovieWatchlist.execute(event.movieDetail);
      final isBookmarked = await getMovieWatchListStatus.execute(event.movieDetail.id);
      final movies = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(StateErrorMovieWatchList(message: failure.message));
        },
        (message) {
          movies.fold(
            (failure) {
              emit(StateErrorMovieWatchList(message: failure.message));
            },
            (data) {
              emit(StateMovieWatchList(movies: data));
              emit(StateWatchListStatusMovie(isFavorite: isBookmarked));
            },
          );
        },
      );
    });
    //watchlist remove
    on<OnMovieRemoveWatchList>((event, emit) async {
      emit(StateLoadingMovieWatchList());
      final result = await removeMovieWatchlist.execute(event.movieDetail);
      final isBookmarked = await getMovieWatchListStatus.execute(event.movieDetail.id);
      final movies = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(StateErrorMovieWatchList(message: failure.message));
        },
        (message) {
          movies.fold(
            (failure) {
              emit(StateErrorMovieWatchList(message: failure.message));
            },
            (data) {
              emit(StateMovieWatchList(movies: data));
              emit(StateWatchListStatusMovie(isFavorite: isBookmarked));
            },
          );
        },
      );
    });
  }
}
