import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/usecases/get_tv_detail.dart';
import 'package:lib_core/domain/usecases/get_tv_recommendations.dart';
import 'package:lib_core/domain/usecases/get_watchlist_status.dart';
import 'package:lib_core/domain/usecases/remove_watchlist.dart';
import 'package:lib_core/domain/usecases/save_watchlist.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/tv_detail_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';



@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTv = testTv;
  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tvs when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tvRecommendations, tTvs);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update recommendation state when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('on error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
