import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/movie.dart';
import 'package:m_movie/domain/usecases/get_movie_now_playing.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_helpers/test_helper.mocks.dart';

void main() {
  late GetMovieNowPlaying useCase;
  late MockMovieInterface mockMovieInterface;

  setUp(() {
    mockMovieInterface = MockMovieInterface();
    useCase = GetMovieNowPlaying(mockMovieInterface);
  });

  final tMovies = <Movie>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieInterface.getNowPlayingMovies()).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
