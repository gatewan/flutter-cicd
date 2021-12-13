import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:m_movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail}) : super(StateEmptyDetail()) {
    //fetch movie detail
    on<OnMovieDetail>((event, emit) async {
      emit(StateLoadingDetail());
      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(StateErrorDetail(message: failure.message));
        },
        (moviesData) {
          emit(StateMovieDetail(movieDetail: moviesData));
        },
      );
    });
  }
}
