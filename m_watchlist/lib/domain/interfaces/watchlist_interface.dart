import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/utils/failure.dart';

abstract class WatchListInterface {
  Future<Either<Failure, String>> saveWatchlistMovie(MovieDetail movie);

  Future<Either<Failure, String>> removeWatchlistMovie(MovieDetail movie);

  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);

  Future<Either<Failure, List<Movie>>> getWatchlistMovies();

  Future<Either<Failure, List<Tv>>> getWatchlistTvs();

  Future<bool> isWatchlistMovie(int id);

  Future<bool> isWatchlistTv(int id);
}
