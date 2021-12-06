import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
