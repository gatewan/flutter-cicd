import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_top_rated.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_helpers/test_helper.mocks.dart';

void main() {
  late GetMovieTopRated usecase;
  late MockMovieInterface mockMovieInterface;

  setUp(() {
    mockMovieInterface = MockMovieInterface();
    usecase = GetMovieTopRated(mockMovieInterface);
  });

  final tMovies = <Movie>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockMovieInterface.getTopRatedMovies()).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
