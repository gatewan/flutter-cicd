import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/lib_core.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);

  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);

  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);

  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
