import 'package:m_watchlist/domain/interfaces/watchlist_interface.dart';

class GetTvWatchListStatus {
  final WatchListInterface interface;

  GetTvWatchListStatus(this.interface);

  Future<bool> execute(int id) async {
    return interface.isWatchlistTv(id);
  }
}
