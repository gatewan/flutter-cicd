import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_popular.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMoviePopular useCase;
  late MockMovieInterface mockMovieInterface;

  setUp(() {
    mockMovieInterface = MockMovieInterface();
    useCase = GetMoviePopular(mockMovieInterface);
  });

  final tMovies = <Movie>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test('should get list of movies from the repository when execute function is called', () async {
        // arrange
        when(mockMovieInterface.getPopularMovies()).thenAnswer((_) async => Right(tMovies));
        // act
        final result = await useCase.execute();
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
