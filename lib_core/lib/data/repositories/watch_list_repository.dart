import 'package:dartz/dartz.dart';
import 'package:lib_core/data/models/movie_table.dart';
import 'package:lib_core/data/models/tv_table.dart';
import 'package:lib_core/data/sources/local/movie_local_data_source.dart';
import 'package:lib_core/data/sources/local/tv_local_data_source.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/utils/failure.dart';
import 'package:m_watchlist/m_watchlist.dart';

import '../../lib_core.dart';

class WatchListRepositoryImpl implements WatchListInterface {
  final MovieLocalDataSource movieLocalDataSource;
  final TvLocalDataSource tvLocalDataSource;

  WatchListRepositoryImpl({
    required this.movieLocalDataSource,
    required this.tvLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await movieLocalDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTvs() async {
    final result = await tvLocalDataSource.getWatchlistTvs();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> removeWatchlistMovie(MovieDetail movie) async {
    try {
      final result = await movieLocalDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv) async {
    try {
      final result = await tvLocalDataSource.removeWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistMovie(MovieDetail movie) async {
    try {
      final result = await movieLocalDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv) async {
    try {
      final result = await tvLocalDataSource.insertWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isWatchlistMovie(int id) async {
    final result = await movieLocalDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<bool> isWatchlistTv(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }
}
