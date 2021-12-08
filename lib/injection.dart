import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:lib_core/data/repositories/movie_repository_impl.dart';
import 'package:lib_core/data/repositories/tv_repository_impl.dart';
import 'package:lib_core/data/sources/local/db/database_helper.dart';
import 'package:lib_core/data/sources/local/movie_local_data_source.dart';
import 'package:lib_core/data/sources/local/tv_local_data_source.dart';
import 'package:lib_core/data/sources/remote/movie_remote_data_source.dart';
import 'package:lib_core/data/sources/remote/tv_remote_data_source.dart';
import 'package:lib_core/domain/repositories/movie_repository.dart';
import 'package:lib_core/domain/repositories/tv_repository.dart';
import 'package:lib_core/domain/usecases/get_movie_detail.dart';
import 'package:lib_core/domain/usecases/get_movie_recommendations.dart';
import 'package:lib_core/domain/usecases/get_now_playing_movies.dart';
import 'package:lib_core/domain/usecases/get_now_playing_tvs.dart';
import 'package:lib_core/domain/usecases/get_popular_movies.dart';
import 'package:lib_core/domain/usecases/get_popular_tvs.dart';
import 'package:lib_core/domain/usecases/get_top_rated_movies.dart';
import 'package:lib_core/domain/usecases/get_top_rated_tvs.dart';
import 'package:lib_core/domain/usecases/get_tv_detail.dart';
import 'package:lib_core/domain/usecases/get_tv_recommendations.dart';
import 'package:lib_core/domain/usecases/get_watchlist_movies.dart';
import 'package:lib_core/domain/usecases/get_watchlist_status.dart';
import 'package:lib_core/domain/usecases/get_watchlist_tvs.dart';
import 'package:lib_core/domain/usecases/remove_watchlist.dart';
import 'package:lib_core/domain/usecases/save_watchlist.dart';
import 'package:lib_core/domain/usecases/search_movies.dart';
import 'package:lib_core/domain/usecases/search_tvs.dart';
import 'package:lib_core/presentation/provider/movie_detail_notifier.dart';
import 'package:lib_core/presentation/provider/movie_list_notifier.dart';
import 'package:lib_core/presentation/provider/movie_search_notifier.dart';
import 'package:lib_core/presentation/provider/popular_movies_notifier.dart';
import 'package:lib_core/presentation/provider/popular_tv_notifier.dart';
import 'package:lib_core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:lib_core/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:lib_core/presentation/provider/tv_detail_notifier.dart';
import 'package:lib_core/presentation/provider/tv_list_notifier.dart';
import 'package:lib_core/presentation/provider/tv_search_notifier.dart';
import 'package:lib_core/presentation/provider/watchlist_movie_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsNotifier(
      getTopRatedTvs: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(sslClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(() => TvRemoteDataSourceImpl(sslClient: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(() => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpClient());
}
