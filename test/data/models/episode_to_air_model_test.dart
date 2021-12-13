
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/episode_to_air_model.dart';
import 'package:lib_core/domain/entities/episode_to_air.dart';

void main() {
  final tTEpisodeToAirModel = TEpisodeToAirModel(
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

  final tTEpisodeToAir = TEpisodeToAir(
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

  test('should be a subclass of TEpisodeToAir By entity', () async {
    final result = tTEpisodeToAirModel.toEntity();
    expect(result, tTEpisodeToAir);
  });
}
