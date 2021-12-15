import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/usecases/search_tv.dart';
import 'package:m_tv/m_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_tv_objects.dart';
import 'tv_search_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late MockSearchTvs mockSearchTvs;
  late TvSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    movieSearchBloc = TvSearchBloc(searchTvs: mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, StateEmptySearch());
  });

  group('get Search Tvs', () {
    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, Error] when get Search Tv failed',
      build: () {
        when(mockSearchTvs.execute("Spider-Man")).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(query: "Spider-Man")),
      expect: () => [StateLoadingSearch(), const StateErrorSearch(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockSearchTvs.execute("Spider-Man"));
      },
    );

    blocTest<TvSearchBloc, TvSearchState>(
      'should emit [Loading, Data] when get Search Tv successful',
      build: () {
        when(mockSearchTvs.execute("Spider-Man")).thenAnswer((_) async => Right([testTv]));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(query: "Spider-Man")),
      expect: () => [
        StateLoadingSearch(),
        StateHasData(result: [testTv])
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute("Spider-Man"));
      },
    );
  });
}
