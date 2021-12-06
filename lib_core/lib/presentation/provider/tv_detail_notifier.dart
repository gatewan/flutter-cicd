import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/domain/usecases/get_tv_detail.dart';
import 'package:lib_core/domain/usecases/get_tv_recommendations.dart';
import 'package:lib_core/domain/usecases/get_watchlist_status.dart';
import 'package:lib_core/domain/usecases/remove_watchlist.dart';
import 'package:lib_core/domain/usecases/save_watchlist.dart';
import 'package:lib_core/lib_core.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvDetail _tv;

  TvDetail get tv => _tv;

  RequestState _tvState = RequestState.empty;

  RequestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];

  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationState = RequestState.loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvs) {
            _recommendationState = RequestState.loaded;
            _tvRecommendations = tvs;
          },
        );
        _tvState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tv) async {
    final tvToMovie = MovieDetail(
      adult: tv.inProduction,
      backdropPath: tv.backdropPath,
      genres: tv.genres,
      id: tv.id,
      originalTitle: tv.originalName,
      overview: tv.overview,
      posterPath: tv.posterPath,
      releaseDate: tv.firstAirDate.toString(),
      runtime: tv.numberOfEpisodes,
      title: tv.name,
      voteAverage: tv.voteAverage.toDouble(),
      voteCount: tv.voteCount,
      isMovie: tv.isMovie,
    );
    final result = await saveWatchlist.execute(tvToMovie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final tvToMovie = MovieDetail(
      adult: tv.inProduction,
      backdropPath: tv.backdropPath,
      genres: tv.genres,
      id: tv.id,
      originalTitle: tv.originalName,
      overview: tv.overview,
      posterPath: tv.posterPath,
      releaseDate: tv.firstAirDate.toString(),
      runtime: tv.numberOfEpisodes,
      title: tv.name,
      voteAverage: tv.voteAverage.toDouble(),
      voteCount: tv.voteCount,
      isMovie: true,
    );
    final result = await removeWatchlist.execute(tvToMovie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
