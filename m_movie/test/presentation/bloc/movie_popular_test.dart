import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/usecases/get_movie_popular.dart';
import 'package:m_movie/m_movie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import 'movie_popular_test.mocks.dart';

@GenerateMocks([GetMoviePopular])
void main() {
  late MockGetMoviePopular mockGetMoviePopular;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetMoviePopular = MockGetMoviePopular();
    moviePopularBloc = MoviePopularBloc(getPopularMovies: mockGetMoviePopular);
  });

  test('initial state should be empty', () {
    expect(moviePopularBloc.state, StateEmptyPopular());
  });

  group('get popular Movies', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, Error] when get popular movie failed',
      build: () {
        when(mockGetMoviePopular.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(const OnMoviePopular()),
      expect: () => [StateLoadingPopular(), const StateErrorPopular(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetMoviePopular.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, Data] when get popular movie successful',
      build: () {
        when(mockGetMoviePopular.execute()).thenAnswer((_) async => Right([testMovie]));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(const OnMoviePopular()),
      expect: () => [
        StateLoadingPopular(),
        StateMoviePopular(movies: [testMovie])
      ],
      verify: (bloc) {
        verify(mockGetMoviePopular.execute());
      },
    );
  });
}
