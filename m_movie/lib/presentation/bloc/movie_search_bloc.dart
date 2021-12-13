import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/search_movie.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(StateEmptySearch()) {
    on<OnQueryChanged>((event, emit) async {
      emit(StateLoadingSearch());
      final result = await searchMovies.execute(event.query);
      result.fold(
        (failure) {
          emit(StateErrorSearch(message: failure.message));
        },
        (moviesData) {
          emit(StateHasData(result: moviesData));
        },
      );
    });
  }
}
