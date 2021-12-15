import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/usecases/get_tv_top_rated.dart';
import 'package:m_tv/m_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_tv_objects.dart';
import 'tv_top_rated_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TvTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTvTopRated = MockGetTvTopRated();
    movieTopRatedBloc = TvTopRatedBloc(getTopRatedTvs: mockGetTvTopRated);
  });

  test('initial state should be empty', () {
    expect(movieTopRatedBloc.state, StateEmptyTopRated());
  });

  group('get Top Rated Tvs', () {
    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, Error] when get Top Rated Tv failed',
      build: () {
        when(mockGetTvTopRated.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(const OnTvTopRated()),
      expect: () => [StateLoadingTopRated(), const StateErrorTopRated(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetTvTopRated.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, Data] when get Top Rated Tv successful',
      build: () {
        when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right([testTv]));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(const OnTvTopRated()),
      expect: () => [
        StateLoadingTopRated(),
        StateTvTopRated(tvs: [testTv])
      ],
      verify: (bloc) {
        verify(mockGetTvTopRated.execute());
      },
    );
  });
}
