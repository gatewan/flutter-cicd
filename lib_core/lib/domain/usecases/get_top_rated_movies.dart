import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
