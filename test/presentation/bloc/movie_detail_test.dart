import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/utils/failure.dart';
import 'package:m_movie/domain/usecases/get_movie_detail.dart';
import 'package:m_movie/m_movie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, StateEmptyDetail());
  });

  group('get Now Playing Movies', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Error] when get detail movie failed',
      build: () {
        when(mockGetMovieDetail.execute(1)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetail(id: 1)),
      expect: () => [StateLoadingDetail(), StateErrorDetail(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Data] when get detail movie successful',
      build: () {
        when(mockGetMovieDetail.execute(1)).thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetail(id: 1)),
      expect: () => [StateLoadingDetail(), StateMovieDetail(movieDetail: testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
      },
    );
  });
}
