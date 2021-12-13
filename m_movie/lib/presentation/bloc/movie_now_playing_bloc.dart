import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_now_playing.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetMovieNowPlaying getNowPlayingMovies;

  MovieNowPlayingBloc({required this.getNowPlayingMovies}) : super(StateEmptyNowPlaying()) {
    //fetch movie now playing
    on<OnMovieNowPlaying>((event, emit) async {
      emit(StateLoadingNowPlaying());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(StateErrorNowPlaying(message: failure.message));
        },
        (moviesData) {
          emit(StateMovieNowPlaying(movies: moviesData));
        },
      );
    });
  }
}
