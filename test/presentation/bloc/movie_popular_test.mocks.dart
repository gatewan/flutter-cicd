// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/presentation/bloc/movie_popular_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:lib_core/domain/entities/movie.dart' as _i7;
import 'package:lib_core/lib_core.dart' as _i6;
import 'package:m_movie/domain/interfaces/movie_interface.dart' as _i2;
import 'package:m_movie/domain/usecases/get_movie_popular.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieInterface_0 extends _i1.Fake implements _i2.MovieInterface {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetMoviePopular].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMoviePopular extends _i1.Mock implements _i4.GetMoviePopular {
  MockGetMoviePopular() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieInterface get interface =>
      (super.noSuchMethod(Invocation.getter(#interface),
          returnValue: _FakeMovieInterface_0()) as _i2.MovieInterface);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>);
  @override
  String toString() => super.toString();
}
