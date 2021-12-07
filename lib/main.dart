import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_core/lib_core.dart';
import 'package:lib_core/presentation/pages/home_movie_page.dart';
import 'package:lib_core/presentation/pages/movie_detail_page.dart';
import 'package:lib_core/presentation/pages/popular_movies_page.dart';
import 'package:lib_core/presentation/pages/search_page.dart';
import 'package:lib_core/presentation/pages/top_rated_movies_page.dart';
import 'package:lib_core/presentation/pages/watchlist_movies_page.dart';
import 'package:lib_core/presentation/provider/movie_detail_notifier.dart';
import 'package:lib_core/presentation/provider/movie_list_notifier.dart';
import 'package:lib_core/presentation/provider/movie_search_notifier.dart';
import 'package:lib_core/presentation/provider/popular_movies_notifier.dart';
import 'package:lib_core/presentation/provider/popular_tv_notifier.dart';
import 'package:lib_core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:lib_core/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:lib_core/presentation/provider/tv_detail_notifier.dart';
import 'package:lib_core/presentation/provider/tv_list_notifier.dart';
import 'package:lib_core/presentation/provider/tv_search_notifier.dart';
import 'package:lib_core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:lib_core/utils/routes.dart';
import 'package:m_about/m_about.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case routePopularMovie:
              final arg = settings.arguments as bool;
              return CupertinoPageRoute(
                builder: (_) => PopularMoviesPage(
                  isMovie: arg,
                ),
                settings: settings,
              );
            case routeTopRateMovie:
              final arg = settings.arguments as bool;
              return CupertinoPageRoute(
                  builder: (_) => TopRatedMoviesPage(
                        isMovie: arg,
                      ));
            case routeDetailMovie:
              final arg = settings.arguments as List<dynamic>;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(
                  id: arg[0],
                  isMovie: arg[1],
                ),
                settings: settings,
              );
            case routeSearchMovie:
              final arg = settings.arguments as bool;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        isMovie: arg,
                      ));
            case routeWatchListMovie:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
