import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/utils/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    debugPrint('WTF: movie use case');
    return repository.getNowPlayingMovies();
  }
}
