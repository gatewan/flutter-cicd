import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_popular.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetMoviePopular getPopularMovies;

  MoviePopularBloc({required this.getPopularMovies}) : super(StateEmptyPopular()) {
    //fetch movie popular
    on<OnMoviePopular>((event, emit) async {
      emit(StateLoadingPopular());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(StateErrorPopular(message: failure.message));
        },
        (moviesData) {
          emit(StateMoviePopular(movies: moviesData));
        },
      );
    });
  }
}
