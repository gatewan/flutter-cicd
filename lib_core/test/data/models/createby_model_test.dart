
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/data/models/createby_model.dart';
import 'package:lib_core/domain/entities/createdby.dart';

void main() {
  final tCreateByModel = CreatedByModel(
    id: 1,
    creditId: "xx1",
    name: "tester",
    gender: 0,
    profilePath: "/example.path",
  );

  final tCreatedBy = CreatedBy(
    id: 1,
    creditId: "xx1",
    name: "tester",
    gender: 0,
    profilePath: "/example.path",
  );

  test('should be a subclass of Created By entity', () async {
    final result = tCreateByModel.toEntity();
    expect(result, tCreatedBy);
  });
}
