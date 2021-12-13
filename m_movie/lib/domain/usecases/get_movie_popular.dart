import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/interfaces/movie_interface.dart';

class GetMoviePopular {
  final MovieInterface interface;

  GetMoviePopular(this.interface);

  Future<Either<Failure, List<Movie>>> execute() {
    return interface.getPopularMovies();
  }
}
