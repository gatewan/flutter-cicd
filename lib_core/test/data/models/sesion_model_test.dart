
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/session_model.dart';
import 'package:lib_core/domain/entities/session.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: DateTime.parse("2022-02-22"),
    episodeCount: 100,
    id: 1,
    name: "tester",
    overview: "lorem ipsum gipsum tulang sumsum",
    posterPath: "/simple.path",
    seasonNumber: 3,
  );

  final tSeason = Season(
    airDate: DateTime.parse("2022-02-22"),
    episodeCount: 100,
    id: 1,
    name: "tester",
    overview: "lorem ipsum gipsum tulang sumsum",
    posterPath: "/simple.path",
    seasonNumber: 3,
  );

  test('should be a subclass of Season By entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
