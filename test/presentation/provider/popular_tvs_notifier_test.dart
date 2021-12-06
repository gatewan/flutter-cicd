import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/usecases/get_popular_tvs.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/provider/popular_tv_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'popular_tvs_notifier_test.mocks.dart';


@GenerateMocks([GetPopularTvs])
void main() {
  late MockGetPopularTvs mockGetPopularTvs;
  late PopularTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvs = MockGetPopularTvs();
    notifier = PopularTvsNotifier(mockGetPopularTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = testTv;

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvs.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvs();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
