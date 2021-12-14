import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/utils/failure.dart';
import 'package:m_tv/domain/usecases/get_tv_detail.dart';
import 'package:m_tv/m_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_tv_objects.dart';
import 'tv_detail_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late TvDetailBloc movieDetailBloc;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    movieDetailBloc = TvDetailBloc(getTvDetail: mockGetTvDetail);
  });

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, StateEmptyDetail());
  });

  group('get Now Playing Tvs', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Error] when get detail movie failed',
      build: () {
        when(mockGetTvDetail.execute(1)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnTvDetail(id: 1)),
      expect: () => [StateLoadingDetail(), StateErrorDetail(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(1));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Data] when get detail movie successful',
      build: () {
        when(mockGetTvDetail.execute(1)).thenAnswer((_) async => Right(testTvDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnTvDetail(id: 1)),
      expect: () => [StateLoadingDetail(), StateTvDetail(tvDetail: testTvDetail)],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(1));
      },
    );
  });
}
