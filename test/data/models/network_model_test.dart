
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/network_model.dart';
import 'package:lib_core/domain/entities/network.dart';

void main() {
  final tNetworkModel = NetworkModel(
    name: "tester",
    id: 1,
    logoPath: "/simple.path",
    originCountry: "id",
  );

  final tNetwork = Network(
    name: "tester",
    id: 1,
    logoPath: "/simple.path",
    originCountry: "id",
  );

  test('should be a subclass of Network By entity', () async {
    final result = tNetworkModel.toEntity();
    expect(result, tNetwork);
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tNetworkModel.toJson();

      final expectedJsonMap = {'name': 'tester', 'id': 1, 'logo_path': '/simple.path', 'origin_country': 'id'};
      expect(result, expectedJsonMap);
    });
  });
}
