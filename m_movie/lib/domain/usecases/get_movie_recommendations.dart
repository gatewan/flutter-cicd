import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/interfaces/movie_interface.dart';

class GetMovieRecommendations {
  final MovieInterface interface;

  GetMovieRecommendations(this.interface);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return interface.getMovieRecommendations(id);
  }
}
