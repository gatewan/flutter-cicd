import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/usecases/get_tv_recommendations.dart';
import 'package:m_tv/m_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_tv_objects.dart';
import 'tv_recommendation_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendation;
  late TvRecommendationBloc tvRecommendationBloc;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendations();
    tvRecommendationBloc = TvRecommendationBloc(getTvRecommendations: mockGetTvRecommendation);
  });

  test('initial state should be empty', () {
    expect(tvRecommendationBloc.state, StateEmptyRecommendation());
  });

  group('get Recommendation Tvs', () {
    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'should emit [Loading, Error] when get Recommendation Tv failed',
      build: () {
        when(mockGetTvRecommendation.execute(1)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnTvRecommendation(id: 1)),
      expect: () => [StateLoadingRecommendation(), StateErrorRecommendation(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(1));
      },
    );

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'should emit [Loading, Data] when get Recommendation Tv successful',
      build: () {
        when(mockGetTvRecommendation.execute(1)).thenAnswer((_) async => Right([testTv]));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnTvRecommendation(id: 1)),
      expect: () => [
        StateLoadingRecommendation(),
        StateTvRecommendation(tvs: [testTv])
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendation.execute(1));
      },
    );
  });
}
