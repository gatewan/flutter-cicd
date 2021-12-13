import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class GetMovieWatchlist {
  final WatchListInterface interface;

  GetMovieWatchlist(this.interface);

  Future<Either<Failure, List<Movie>>> execute() {
    return interface.getWatchlistMovies();
  }
}
