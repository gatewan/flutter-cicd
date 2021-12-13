import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/interfaces/movie_interface.dart';

class GetMovieDetail {
  final MovieInterface interface;

  GetMovieDetail(this.interface);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return interface.getMovieDetail(id);
  }
}
