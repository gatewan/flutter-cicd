import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class RemoveMovieWatchlist {
  final WatchListInterface interface;

  RemoveMovieWatchlist(this.interface);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return interface.removeWatchlistMovie(movie);
  }
}
