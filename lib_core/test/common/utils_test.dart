import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/lib_core.dart';

void main() {
  final now = DateTime.parse("2021-11-30");
  const testDate = "November 30, 2021";

  test('should be a formatting date time to MMMM dd, yyyy', () async {
    final result = formattedDate(now);
    expect(result, testDate);
  });
}
