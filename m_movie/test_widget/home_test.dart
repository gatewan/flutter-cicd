import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m_movie/presentation/pages/movie_home_page.dart';

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    final findPopular = find.byKey(const ValueKey('Popular'));
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MaterialApp(home: MovieHomePage()));
    await tester.tap(findPopular);
    await tester.pump();
    // Create the Finders.
    final topListTitleFinder = find.text('Now Playing');
    // Verify
    expect(topListTitleFinder, findsOneWidget);
  });
}
