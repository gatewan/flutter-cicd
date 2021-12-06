
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/spoken_language_model.dart';
import 'package:lib_core/domain/entities/spoken_language.dart';

void main() {
  final tSpokenLanguageModel = SpokenLanguageModel(
    englishName: "eng",
    iso6391: "iso6391",
    name: "tester",
  );

  final tSpokenLanguage = SpokenLanguage(
    englishName: "eng",
    iso6391: "iso6391",
    name: "tester",
  );

  test('should be a subclass of SpokenLanguage By entity', () async {
    final result = tSpokenLanguageModel.toEntity();
    expect(result, tSpokenLanguage);
  });
}
