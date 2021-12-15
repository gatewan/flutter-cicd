import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/useCases/search_movie.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies useCase;
  late MockMovieInterface mockMovieInterface;

  setUp(() {
    mockMovieInterface = MockMovieInterface();
    useCase = SearchMovies(mockMovieInterface);
  });

  final tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieInterface.searchMovies(tQuery)).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}
