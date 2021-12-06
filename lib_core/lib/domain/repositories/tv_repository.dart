import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/lib_core.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTvs();

  Future<Either<Failure, List<Tv>>> getPopularTvs();

  Future<Either<Failure, List<Tv>>> getTopRatedTvs();

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);

  Future<Either<Failure, List<Tv>>> searchTvs(String query);

  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<Tv>>> getWatchlistTvs();
}
