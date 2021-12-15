import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_movie/domain/usecases/search_movie.dart';
import 'package:m_movie/m_movie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../xtra_dummy/dummy_movie_objects.dart';
import 'movie_search_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, StateEmptySearch());
  });

  group('get Search Movies', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Error] when get Search movie failed',
      build: () {
        when(mockSearchMovies.execute("Spider-Man")).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(query: "Spider-Man")),
      expect: () => [StateLoadingSearch(), StateErrorSearch(message: 'Server Failure')],
      verify: (bloc) {
        verify(mockSearchMovies.execute("Spider-Man"));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Data] when get Search movie successful',
      build: () {
        when(mockSearchMovies.execute("Spider-Man")).thenAnswer((_) async => Right([testMovie]));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(query: "Spider-Man")),
      expect: () => [
        StateLoadingSearch(),
        StateHasData(result: [testMovie])
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute("Spider-Man"));
      },
    );
  });
}
