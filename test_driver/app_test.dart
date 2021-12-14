

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Testing App', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('Home module test', () async {
      final firstItem = find.text('Now Playing');
      final secondItem = find.text('Popular');
      final thirdItem = find.text('Top Rated');

      expect(await driver.getText(firstItem), 'Now Playing');
      expect(await driver.getText(secondItem), 'Popular');
      expect(await driver.getText(thirdItem), 'Top Rated');

      await driver.tap(find.byValueKey('Popular'));
    });

    test('Popular list module test', () async {
      final listFinder = find.byType('ListView');

      final firstItem = find.text('Encanto');
      final secondItem = find.text('No Time to Die');
      final thirdItem = find.text('Red Notice');

      await driver.scrollUntilVisible(listFinder, firstItem, dyScroll: -300);
      await driver.scrollUntilVisible(listFinder, secondItem, dyScroll: -100);
      await driver.scrollUntilVisible(listFinder, thirdItem, dyScroll: 300);

      await driver.tap(find.pageBack());
    });
  });
}
