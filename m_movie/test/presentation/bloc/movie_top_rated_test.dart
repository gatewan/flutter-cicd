import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/usecases/get_movie_top_rated.dart';
import 'package:m_movie/m_movie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import 'movie_top_rated_test.mocks.dart';

@GenerateMocks([GetMovieTopRated])
void main() {
  late MockGetMovieTopRated mockGetMovieTopRated;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetMovieTopRated = MockGetMovieTopRated();
    movieTopRatedBloc = MovieTopRatedBloc(getTopRatedMovies: mockGetMovieTopRated);
  });

  test('initial state should be empty', () {
    expect(movieTopRatedBloc.state, StateEmptyTopRated());
  });

  group('get Top Rated Movies', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, Error] when get Top Rated movie failed',
      build: () {
        when(mockGetMovieTopRated.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(OnMovieTopRated()),
      expect: () => [StateLoadingTopRated(), StateErrorTopRated(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieTopRated.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, Data] when get Top Rated movie successful',
      build: () {
        when(mockGetMovieTopRated.execute()).thenAnswer((_) async => Right([testMovie]));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(OnMovieTopRated()),
      expect: () => [
        StateLoadingTopRated(),
        StateMovieTopRated(movies: [testMovie])
      ],
      verify: (bloc) {
        verify(mockGetMovieTopRated.execute());
      },
    );
  });
}
