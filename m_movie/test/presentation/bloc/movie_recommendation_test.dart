import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:m_movie/m_movie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import 'movie_recommendation_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendation;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(getMovieRecommendations: mockGetMovieRecommendation);
  });

  test('initial state should be empty', () {
    expect(movieRecommendationBloc.state, StateEmptyRecommendation());
  });

  group('get Recommendation Movies', () {
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [Loading, Error] when get Recommendation movie failed',
      build: () {
        when(mockGetMovieRecommendation.execute(1))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendation(id: 1)),
      expect: () => [StateLoadingRecommendation(), const StateErrorRecommendation(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieRecommendation.execute(1));
      },
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'should emit [Loading, Data] when get Recommendation movie successful',
      build: () {
        when(mockGetMovieRecommendation.execute(1)).thenAnswer((_) async => Right([testMovie]));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendation(id: 1)),
      expect: () => [
        StateLoadingRecommendation(),
        StateMovieRecommendation(movies: [testMovie])
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendation.execute(1));
      },
    );
  });
}
