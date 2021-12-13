import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class RemoveTvWatchlist {
  final WatchListInterface interface;

  RemoveTvWatchlist(this.interface);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return interface.removeWatchlistTv(tv);
  }
}
