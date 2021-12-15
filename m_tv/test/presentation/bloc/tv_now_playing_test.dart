import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/usecases/get_tv_now_playing.dart';
import 'package:m_tv/m_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_tv_objects.dart';
import 'tv_now_playing_test.mocks.dart';

@GenerateMocks([GetTvNowPlaying])
void main() {
  late MockGetTvNowPlaying mockGetTvNowPlaying;
  late TvNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetTvNowPlaying = MockGetTvNowPlaying();
    movieNowPlayingBloc = TvNowPlayingBloc(getNowPlayingTvs: mockGetTvNowPlaying);
  });

  test('initial state should be empty', () {
    expect(movieNowPlayingBloc.state, StateEmptyNowPlaying());
  });

  group('get Now Playing Tvs', () {
    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'should emit [Loading, Error] when get now playing tv failed',
      build: () {
        when(mockGetTvNowPlaying.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(OnTvNowPlaying()),
      expect: () => [StateLoadingNowPlaying(), StateErrorNowPlaying(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetTvNowPlaying.execute());
      },
    );

    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'should emit [Loading, Data] when get now playing tv successful',
      build: () {
        when(mockGetTvNowPlaying.execute()).thenAnswer((_) async => Right([testTv]));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(OnTvNowPlaying()),
      expect: () => [
        StateLoadingNowPlaying(),
        StateTvNowPlaying(tvs: [testTv])
      ],
      verify: (bloc) {
        verify(mockGetTvNowPlaying.execute());
      },
    );
  });
}
