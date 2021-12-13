import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_top_rated.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetMovieTopRated getTopRatedMovies;

  MovieTopRatedBloc({required this.getTopRatedMovies}) : super(StateEmptyTopRated()) {
    //fetch movie top rated
    on<OnMovieTopRated>((event, emit) async {
      emit(StateLoadingTopRated());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(StateErrorTopRated(message: failure.message));
        },
        (moviesData) {
          emit(StateMovieTopRated(movies: moviesData));
        },
      );
    });
  }
}
