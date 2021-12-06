import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/lib_core.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
