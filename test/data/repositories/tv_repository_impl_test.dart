import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/tv_detail_model.dart';
import 'package:lib_core/data/models/tv_model.dart';
import 'package:lib_core/data/repositories/tv_repository_impl.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvModel = TvModel(
    backdropPath: "https://n-a",
    firstAirDate: "01-01-2011",
    genreIds: [1, 2, 3],
    id: 1,
    name: "dummy",
    originCountry: ["Jogja", "Yogyakarta"],
    originalLanguage: "English",
    originalName: "dummy name",
    overview: "lorem insum gipsum",
    popularity: 9.0,
    posterPath: "/test",
    voteAverage: 7.8,
    voteCount: 8,
  );

  final tTv = Tv(
    backdropPath: "https://n-a",
    firstAirDate: "01-01-2011",
    genreIds: [1, 2, 3],
    id: 1,
    name: "dummy",
    originCountry: ["Jogja", "Yogyakarta"],
    originalLanguage: "English",
    originalName: "dummy name",
    overview: "lorem insum gipsum",
    popularity: 9.0,
    posterPath: "/test",
    voteAverage: 7.8,
    voteCount: 8,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing Tvs', () {
    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvs()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvs());
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tvs', () {
    test('should return tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvs()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tvs', () {
    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvs()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvs()).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Detail', () {
    final tId = 1;

    final tTvDetailModel = TvDetailModel(
      backdropPath: "/backdropPath.path",
      createdBy: [createdBy],
      episodeRunTime: [1, 2, 3],
      firstAirDate: DateTime.parse("2022-02-22"),
      genres: [genre],
      homepage: "/homepage",
      id: 1,
      inProduction: false,
      languages: ["id", "en"],
      lastAirDate: DateTime.parse("2022-02-22"),
      lastEpisodeToAir: tepisode,
      name: "testing",
      networks: [network],
      numberOfEpisodes: 33,
      numberOfSeasons: 3,
      originCountry: ["id", "en"],
      originalLanguage: "en",
      originalName: "tester ori",
      overview: "overview",
      popularity: 7.8,
      posterPath: "/posterPath",
      productionCompanies: [network],
      productionCountries: [productionCountry],
      seasons: [season],
      spokenLanguages: [spokenLang],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 9.99,
      voteCount: 1000,
    );

    test('should return Tv data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenAnswer((_) async => tTvDetailModel);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return connection failure when the device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tvs', () {
    final tQuery = 'spiderman';

    test('should return tv list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.searchTvs(tQuery)).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.searchTvs(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
      // arrange
      when(mockRemoteDataSource.searchTvs(tQuery)).thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tvs', () {
    test('should return list of Tvs', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvs()).thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
