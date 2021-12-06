
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/pages/top_rated_movies_page.dart';
import 'package:lib_core/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tvs_page_test.mocks.dart';


@GenerateMocks([TopRatedTvsNotifier])
void main() {
  late MockTopRatedTvsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage(
      isMovie: false,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvs).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage(
      isMovie: false,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error', (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage(
      isMovie: false,
    )));

    expect(textFinder, findsOneWidget);
  });
}
