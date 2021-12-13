import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/useCases/get_movie_recommendations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieRecommendations useCase;
  late MockMovieInterface mockMovieInterface;

  setUp(() {
    mockMovieInterface = MockMovieInterface();
    useCase = GetMovieRecommendations(mockMovieInterface);
  });

  final tId = 1;
  final tMovies = <Movie>[];

  test('should get list of movie recommendations from the repository', () async {
    // arrange
    when(mockMovieInterface.getMovieRecommendations(tId)).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });
}
