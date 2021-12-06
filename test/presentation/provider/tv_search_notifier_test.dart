import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/usecases/search_tvs.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/tv_search_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'tv_search_notifier_test.mocks.dart';


@GenerateMocks([SearchTvs])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTvs mockSearchTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvs = MockSearchTvs();
    provider = TvSearchNotifier(searchTvs: mockSearchTvs)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvModel = testTv;
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'spiderman';

  group('search tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvs.execute(tQuery)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
