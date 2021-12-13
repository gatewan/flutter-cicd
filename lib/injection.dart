import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:lib_core/data/repositories/movie_repository.dart';
import 'package:lib_core/data/repositories/tv_repository.dart';
import 'package:lib_core/data/repositories/watch_list_repository.dart';
import 'package:lib_core/data/sources/local/db/database_helper.dart';
import 'package:lib_core/data/sources/local/movie_local_data_source.dart';
import 'package:lib_core/data/sources/local/tv_local_data_source.dart';
import 'package:lib_core/data/sources/remote/movie_remote_data_source.dart';
import 'package:lib_core/data/sources/remote/tv_remote_data_source.dart';
import 'package:m_movie/domain/interfaces/movie_interface.dart';
import 'package:m_movie/domain/usecases/get_movie_detail.dart';
import 'package:m_movie/domain/usecases/get_movie_now_playing.dart';
import 'package:m_movie/domain/usecases/get_movie_popular.dart';
import 'package:m_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:m_movie/domain/usecases/get_movie_top_rated.dart';
import 'package:m_movie/domain/usecases/search_movie.dart';
import 'package:m_movie/m_movie.dart';
import 'package:m_tv/domain/interface/tv_interface.dart';
import 'package:m_tv/domain/usecases/get_tv_detail.dart';
import 'package:m_tv/domain/usecases/get_tv_now_playing.dart';
import 'package:m_tv/domain/usecases/get_tv_popular.dart';
import 'package:m_tv/domain/usecases/get_tv_recommendations.dart';
import 'package:m_tv/domain/usecases/get_tv_top_rated.dart';
import 'package:m_tv/domain/usecases/search_tv.dart';
import 'package:m_tv/m_tv.dart';
import 'package:m_watchlist/m_watchlist.dart';

final locator = GetIt.instance;

void init() {
  // MOVIE HERE
  locator.registerFactory(
    () => MovieNowPlayingBloc(getNowPlayingMovies: locator()),
  );
  locator.registerFactory(
    () => MoviePopularBloc(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => MovieSearchBloc(searchMovies: locator()),
  );
  locator.registerFactory(
    () => MovieRecommendationBloc(getMovieRecommendations: locator()),
  );
  locator.registerFactory(
    () => MovieDetailBloc(getMovieDetail: locator()),
  );
  // TV HERE
  locator.registerFactory(
    () => TvNowPlayingBloc(getNowPlayingTvs: locator()),
  );
  locator.registerFactory(
    () => TvPopularBloc(getPopularTvs: locator()),
  );
  locator.registerFactory(
    () => TvTopRatedBloc(getTopRatedTvs: locator()),
  );
  locator.registerFactory(
    () => TvSearchBloc(searchTvs: locator()),
  );
  locator.registerFactory(
    () => TvRecommendationBloc(getTvRecommendations: locator()),
  );
  locator.registerFactory(
    () => TvDetailBloc(getTvDetail: locator()),
  );
  locator.registerFactory(() => MovieWatchListBloc(
        getWatchlistMovies: locator(),
        getMovieWatchListStatus: locator(),
        saveMovieWatchlist: locator(),
        removeMovieWatchlist: locator(),
      ));
  locator.registerFactory(() => TvWatchListBloc(
        getWatchlistTvs: locator(),
        getTvWatchListStatus: locator(),
        saveTvWatchlist: locator(),
        removeTvWatchlist: locator(),
      ));

  // USE CASE
  locator.registerLazySingleton(() => GetMovieNowPlaying(locator()));
  locator.registerLazySingleton(() => GetMoviePopular(locator()));
  locator.registerLazySingleton(() => GetMovieTopRated(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetMovieWatchlist(locator()));

  locator.registerLazySingleton(() => GetTvNowPlaying(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetTvWatchlist(locator()));

  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetTvWatchListStatus(locator()));

  // repository
  locator.registerLazySingleton<MovieInterface>(() => MovieRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<TvInterface>(() => TvRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<WatchListInterface>(
    () => WatchListRepositoryImpl(
      movieLocalDataSource: locator(),
      tvLocalDataSource: locator(),
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
