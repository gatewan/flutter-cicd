
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/tv_detail_model.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';

import '../../dummy_data/dummy_tv_objects.dart';

void main() {
  final tTvDetailModel = TvDetailModel(
    backdropPath: "/backdropPath.path",
    createdBy: [createdBy],
    episodeRunTime: [1, 2, 3],
    firstAirDate: DateTime.parse("2022-02-22"),
    genres: [genre],
    homepage: "/homepage",
    id: 1,
    inProduction: false,
    languages: ["id", "en"],
    lastAirDate: DateTime.parse("2022-02-22"),
    lastEpisodeToAir: tepisode,
    name: "testing",
    networks: [network],
    numberOfEpisodes: 33,
    numberOfSeasons: 3,
    originCountry: ["id", "en"],
    originalLanguage: "en",
    originalName: "tester ori",
    overview: "overview",
    popularity: 7.8,
    posterPath: "/posterPath",
    productionCompanies: [network],
    productionCountries: [productionCountry],
    seasons: [season],
    spokenLanguages: [spokenLang],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 9.99,
    voteCount: 1000,
  );

  final tTvDetail = TvDetail(
    backdropPath: "/backdropPath.path",
    createdBy: [createdBy.toEntity()],
    episodeRunTime: [1, 2, 3],
    firstAirDate: DateTime.parse("2022-02-22"),
    genres: [genre.toEntity()],
    homepage: "/homepage",
    id: 1,
    inProduction: false,
    languages: ["id", "en"],
    lastAirDate: DateTime.parse("2022-02-22"),
    lastEpisodeToAir: tepisode.toEntity(),
    name: "testing",
    networks: [network.toEntity()],
    numberOfEpisodes: 33,
    numberOfSeasons: 3,
    originCountry: ["id", "en"],
    originalLanguage: "en",
    originalName: "tester ori",
    overview: "overview",
    popularity: 7.8,
    posterPath: "/posterPath",
    productionCompanies: [network.toEntity()],
    productionCountries: [productionCountry.toEntity()],
    seasons: [season.toEntity()],
    spokenLanguages: [spokenLang.toEntity()],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 9.99,
    voteCount: 1000,
    isMovie: false,
  );

  test('should be a subclass of TvDetail By entity', () async {
    final result = tTvDetailModel.toEntity();
    expect(result, tTvDetail);
  });
}
