import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class GetMovieWatchListStatus {
  final WatchListInterface interface;

  GetMovieWatchListStatus(this.interface);

  Future<bool> execute(int id) async {
    return interface.isWatchlistMovie(id);
  }
}
