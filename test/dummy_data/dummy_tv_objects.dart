

import 'package:lib_core/data/models/createby_model.dart';
import 'package:lib_core/data/models/episode_to_air_model.dart';
import 'package:lib_core/data/models/genre_model.dart';
import 'package:lib_core/data/models/movie_table.dart';
import 'package:lib_core/data/models/network_model.dart';
import 'package:lib_core/data/models/production_country_model.dart';
import 'package:lib_core/data/models/session_model.dart';
import 'package:lib_core/data/models/spoken_language_model.dart';
import 'package:lib_core/data/models/tv_table.dart';
import 'package:lib_core/domain/entities/movie_detail.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';

final createdBy = CreatedByModel(
  id: 1,
  creditId: "xx1",
  name: "tester",
  gender: 0,
  profilePath: "/example.path",
);

final genre = GenreModel(
  id: 1,
  name: "gen",
);

final tepisode = TEpisodeToAirModel(
  airDate: DateTime.parse("2021-11-30"),
  episodeNumber: 9,
  id: 1,
  name: "tester",
  overview: "lorem ipsum gipsum sumsum",
  productionCode: "86",
  seasonNumber: 2,
  stillPath: "/simple.path",
  voteAverage: 9.99,
  voteCount: 1000,
);

final network = NetworkModel(
  name: "tester",
  id: 1,
  logoPath: "/simple.path",
  originCountry: "id",
);

final productionCountry = ProductionCountryModel(
  iso31661: "iso31661",
  name: "tester",
);

final season = SeasonModel(
  airDate: DateTime.parse("2022-02-22"),
  episodeCount: 100,
  id: 1,
  name: "tester",
  overview: "lorem ipsum gipsum tulang sumsum",
  posterPath: "/simple.path",
  seasonNumber: 3,
);

final spokenLang = SpokenLanguageModel(
  englishName: "eng",
  iso6391: "iso6391",
  name: "tester",
);

final testTv = Tv(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
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

final tvToMovieDetail = MovieDetail(
  adult: true,
  backdropPath: testTvDetail.backdropPath,
  genres: testTvDetail.genres,
  id: testTvDetail.id,
  originalTitle: testTvDetail.originalName,
  overview: testTvDetail.overview,
  posterPath: testTvDetail.posterPath,
  releaseDate: testTvDetail.firstAirDate.toString(),
  runtime: testTvDetail.numberOfEpisodes,
  title: testTvDetail.name,
  voteAverage: testTvDetail.voteAverage,
  voteCount: testTvDetail.voteCount,
  isMovie: testTvDetail.isMovie,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  overview: "overview",
  posterPath: "/posterPath",
  name: "name",
);

final testTvTable = TvTable(
  id: 1,
  name: "name",
  posterPath: "/posterPath",
  overview: "overview",
  isMovie: false,
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': '/posterPath',
  'title': 'title',
};

final tvToMovieTable = MovieTable(
  id: testTvTable.id,
  title: testTvTable.name,
  posterPath: testTvTable.posterPath,
  overview: testTvTable.overview,
  isMovie: testTvTable.isMovie,
);
