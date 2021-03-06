import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m_movie/domain/usecases/get_movie_detail.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import '../../xtra_helpers/test_helper.mocks.dart';

void main() {
  late GetMovieDetail useCase;
  late MockMovieInterface mockMovieInterface;

  setUp(() {
    mockMovieInterface = MockMovieInterface();
    useCase = GetMovieDetail(mockMovieInterface);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieInterface.getMovieDetail(tId)).thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
