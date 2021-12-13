import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/utils/failure.dart';
import 'package:m_movie/domain/interfaces/movie_interface.dart';

class GetMovieNowPlaying {
  final MovieInterface interface;

  GetMovieNowPlaying(this.interface);

  Future<Either<Failure, List<Movie>>> execute() {
    debugPrint('WTF: movie use case');
    return interface.getNowPlayingMovies();
  }
}
