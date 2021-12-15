import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/usecases/get_tv_popular.dart';
import 'package:m_tv/m_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_tv_objects.dart';
import 'tv_popular_test.mocks.dart';

@GenerateMocks([GetTvPopular])
void main() {
  late MockGetTvPopular mockGetTvPopular;
  late TvPopularBloc moviePopularBloc;

  setUp(() {
    mockGetTvPopular = MockGetTvPopular();
    moviePopularBloc = TvPopularBloc(getPopularTvs: mockGetTvPopular);
  });

  test('initial state should be empty', () {
    expect(moviePopularBloc.state, StateEmptyPopular());
  });

  group('get popular Tvs', () {
    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, Error] when get popular tv failed',
      build: () {
        when(mockGetTvPopular.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(const OnTvPopular()),
      expect: () => [StateLoadingPopular(), const StateErrorPopular(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetTvPopular.execute());
      },
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, Data] when get popular tv successful',
      build: () {
        when(mockGetTvPopular.execute()).thenAnswer((_) async => Right([testTv]));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(const OnTvPopular()),
      expect: () => [
        StateLoadingPopular(),
        StateTvPopular(tvs: [testTv])
      ],
      verify: (bloc) {
        verify(mockGetTvPopular.execute());
      },
    );
  });
}
