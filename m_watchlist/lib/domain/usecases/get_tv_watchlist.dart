import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class GetTvWatchlist {
  final WatchListInterface interface;

  GetTvWatchlist(this.interface);

  Future<Either<Failure, List<Tv>>> execute() {
    return interface.getWatchlistTvs();
  }
}
