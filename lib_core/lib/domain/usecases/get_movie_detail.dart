import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
