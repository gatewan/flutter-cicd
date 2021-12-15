import 'package:equatable/equatable.dart';
import 'package:lib_core/data/models/createby_model.dart';
import 'package:lib_core/data/models/episode_to_air_model.dart';
import 'package:lib_core/data/models/genre_model.dart';
import 'package:lib_core/data/models/network_model.dart';
import 'package:lib_core/data/models/production_country_model.dart';
import 'package:lib_core/data/models/session_model.dart';
import 'package:lib_core/data/models/spoken_language_model.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/lib_core.dart';

class TvDetailModel extends Equatable {
  TvDetailModel({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  String backdropPath;
  List<CreatedByModel> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<GenreModel> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  TEpisodeToAirModel lastEpisodeToAir;
  String name;
  List<NetworkModel> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<NetworkModel> productionCompanies;
  List<ProductionCountryModel> productionCountries;
  List<SeasonModel> seasons;
  List<SpokenLanguageModel> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        backdropPath: json["backdrop_path"] ?? IMG_NOT_FOUND,
        createdBy: List<CreatedByModel>.from(json["created_by"].map((x) => CreatedByModel.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: TEpisodeToAirModel.fromJson(json["last_episode_to_air"]),
        name: json["name"],
        networks: List<NetworkModel>.from(json["networks"].map((x) => NetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] ?? IMG_NOT_FOUND,
        productionCompanies: List<NetworkModel>.from(json["production_companies"].map((x) => NetworkModel.fromJson(x))),
        productionCountries: List<ProductionCountryModel>.from(
            json["production_countries"].map((x) => ProductionCountryModel.fromJson(x))),
        seasons: List<SeasonModel>.from(json["seasons"].map((x) => SeasonModel.fromJson(x))),
        spokenLanguages:
            List<SpokenLanguageModel>.from(json["spoken_languages"].map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      backdropPath: this.backdropPath,
      createdBy: this.createdBy.map((item) => item.toEntity()).toList(),
      episodeRunTime: this.episodeRunTime,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((item) => item.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      lastAirDate: this.lastAirDate,
      lastEpisodeToAir: this.lastEpisodeToAir.toEntity(),
      name: this.name,
      networks: this.networks.map((item) => item.toEntity()).toList(),
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      productionCompanies: this.productionCompanies.map((item) => item.toEntity()).toList(),
      productionCountries: this.productionCountries.map((item) => item.toEntity()).toList(),
      seasons: this.seasons.map((item) => item.toEntity()).toList(),
      spokenLanguages: this.spokenLanguages.map((item) => item.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      isMovie: false,
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
