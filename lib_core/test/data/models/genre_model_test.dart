
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/genre_model.dart';
import 'package:lib_core/domain/entities/genre.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: "tester",
  );

  final tGenre = Genre(
    id: 1,
    name: "tester",
  );

  test('should be a subclass of Genre By entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });
}
