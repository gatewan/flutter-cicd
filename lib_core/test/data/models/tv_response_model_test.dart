import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/tv_model.dart';
import 'package:lib_core/data/models/tv_response.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/otw.jpg",
    firstAirDate: "01-01-2011",
    genreIds: const [1, 2, 3],
    id: 1,
    name: "dummy",
    originCountry: const ["Jogja", "Yogyakarta"],
    originalLanguage: "en",
    originalName: "dummy name",
    overview: "lorem insum gipsum",
    popularity: 9.0,
    posterPath: "/test",
    voteAverage: 7.8,
    voteCount: 8,
    isMovie: false,
  );

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('xtra_dummy/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/otw.jpg',
            'first_air_date': '01-01-2011',
            'genre_ids': [1, 2, 3],
            'id': 1,
            'name': 'dummy',
            'origin_country': ['Jogja', 'Yogyakarta'],
            'original_language': 'en',
            'original_name': 'dummy name',
            'overview': 'lorem insum gipsum',
            'popularity': 9.0,
            'poster_path': '/test',
            'vote_average': 7.8,
            'vote_count': 8
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
