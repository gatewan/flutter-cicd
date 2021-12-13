import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class SaveTvWatchlist {
  final WatchListInterface interface;

  SaveTvWatchlist(this.interface);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return interface.saveWatchlistTv(tv);
  }
}
