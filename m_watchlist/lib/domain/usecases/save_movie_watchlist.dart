import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class SaveMovieWatchlist {
  final WatchListInterface interface;

  SaveMovieWatchlist(this.interface);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return interface.saveWatchlistMovie(movie);
  }
}
