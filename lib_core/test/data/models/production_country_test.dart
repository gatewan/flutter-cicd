
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/production_country_model.dart';
import 'package:lib_core/domain/entities/production_country.dart';

void main() {
  final tProductionCountryModel = ProductionCountryModel(
    iso31661: "iso31661",
    name: "tester",
  );

  final tProductionCountry = ProductionCountry(
    iso31661: "iso31661",
    name: "tester",
  );

  test('should be a subclass of ProductionCountry By entity', () async {
    final result = tProductionCountryModel.toEntity();
    expect(result, tProductionCountry);
  });
}
