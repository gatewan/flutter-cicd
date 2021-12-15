import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/usecases/get_movie_now_playing.dart';
import 'package:m_movie/m_movie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import 'movie_now_playing_test.mocks.dart';

@GenerateMocks([GetMovieNowPlaying])
void main() {
  late MockGetMovieNowPlaying mockGetMovieNowPlaying;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetMovieNowPlaying = MockGetMovieNowPlaying();
    movieNowPlayingBloc = MovieNowPlayingBloc(getNowPlayingMovies: mockGetMovieNowPlaying);
  });

  test('initial state should be empty', () {
    expect(movieNowPlayingBloc.state, StateEmptyNowPlaying());
  });

  group('get Now Playing Movies', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [Loading, Error] when get now playing movie failed',
      build: () {
        when(mockGetMovieNowPlaying.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnMovieNowPlaying()),
      expect: () => [StateLoadingNowPlaying(), const StateErrorNowPlaying(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieNowPlaying.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [Loading, Data] when get now playing movie successful',
      build: () {
        when(mockGetMovieNowPlaying.execute()).thenAnswer((_) async => Right([testMovie]));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(const OnMovieNowPlaying()),
      expect: () => [
        StateLoadingNowPlaying(),
        StateMovieNowPlaying(movies: [testMovie])
      ],
      verify: (bloc) {
        verify(mockGetMovieNowPlaying.execute());
      },
    );
  });
}
