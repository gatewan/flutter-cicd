
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/tv_model.dart';
import 'package:lib_core/domain/entities/tv.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "https://n-a",
    firstAirDate: "01-01-2011",
    genreIds: [1, 2, 3],
    id: 1,
    name: "dummy",
    originCountry: ["Jogja", "Yogyakarta"],
    originalLanguage: "English",
    originalName: "dummy name",
    overview: "lorem insum gipsum",
    popularity: 9.0,
    posterPath: "/test",
    voteAverage: 7.8,
    voteCount: 8,
  );

  final tTv = Tv(
    backdropPath: "https://n-a",
    firstAirDate: "01-01-2011",
    genreIds: [1, 2, 3],
    id: 1,
    name: "dummy",
    originCountry: ["Jogja", "Yogyakarta"],
    originalLanguage: "English",
    originalName: "dummy name",
    overview: "lorem insum gipsum",
    popularity: 9.0,
    posterPath: "/test",
    voteAverage: 7.8,
    voteCount: 8,
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
